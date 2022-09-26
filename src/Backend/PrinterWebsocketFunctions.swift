//
//  PrinterWebsocketFunctions.swift
//  Plastic
//
//  Created by Charles Pickering on 9/19/22.
//

import Foundation

extension Printer {
    
    // Outgoing Controls (without params)
    mutating func eStop() {
        sendMoonrakerCommand(method: .printerEmergency_stop)
    }
    mutating func hostRestart() {
        sendMoonrakerCommand(method: .printerRestart)
    }
    mutating func firmwareRestart() {
        sendMoonrakerCommand(method: .printerFirmware_restart)
    }
    mutating func queryStatus(){
        Task {
            self.sendMoonrakerCommand(method: .printerInfo)
            self.sendMoonrakerCommand(method: .serverInfo)
            try await Task.sleep(nanoseconds:1_000_000_000)
            self.queryStatus()
        }
    }
    mutating func sendMoonrakerCommand(method: MoonrakerMethod){
        var payload = Data()
        do {
            payload = try JSONEncoder().encode(ParamlessJsonRPCRequest(method: method.rawValue, id: nextJSONid))
            idLookup[nextJSONid] = method
            nextJSONid += 1
        }
        catch {}
        wsocket?.send(.data(payload)) { error in
            if error != nil{
                print(error as Any)
            }
        }
    }
    struct ParamlessJsonRPCRequest: Encodable {
        let jsonrpc = "2.0" //we use a string to override the default json encoding behavior for decimal values.
        let method: String
        let id: Int
    }
    
    // Outgoing Controls (which need params)
    mutating func klipperServiceRestart(){
        var payload = Data()
        struct JsonRPCRequest: Encodable {
            let jsonrpc = "2.0" //we use a string to override the default json encoding behavior for decimal values.
            let method: String
            let id: Int
            let params: [String: String]
        }
        do {
            payload = try JSONEncoder().encode(JsonRPCRequest(method: MoonrakerMethod.serviceKlipperRestart.rawValue, id: nextJSONid, params: ["service" : "klipper"]))
            idLookup[nextJSONid] = .serviceKlipperRestart
            nextJSONid+=1
        } catch {}
        wsocket?.send(.data(payload)) { error in
            if error != nil{
                print(error as Any)
            }
        }
        
        
    }
    
    // Incoming Feedback
    mutating func startReceive() {
        wsocket?.receive() { response in
            switch response {
                
            case .failure:
                print("failed to get message")
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            
            case .success(let message):
                switch message {
                case .data(_):
                    print("expected string from websocket")
                    DispatchQueue.main.async {
                        self.isConnected = false
                    }
                    
                case .string(let string):
                    let data = string.data(using: .utf8)
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                            // If re receive an id, it is a responce to a method.
                            // Handle the response according to the matching method.
                            if let id = json["id"] as? Int {
                                let result = json["result"] as? [String: Any]
                                switch (self.idLookup[id]) {
                                case .printerEmergency_stop:
                                    print("Recived shutdown confirmation")
                                    DispatchQueue.main.async {
                                        self.isShutdown = true
                                    }
                                case .printerInfo:
                                    print("printerinfo")
                                    DispatchQueue.main.async {
                                        if (result != nil){
                                            self.shutdownMessage = result?["state_message"] as! String
                                        }
                                    }
                                    print(result)
                                case .none:
                                    print("no method registered")
                                case .some(.printerRestart):
                                    print("printer restarted")
                                case .some(.printerFirmware_restart):
                                    print("printer firmware restarted")
                                case .serverInfo:
                                    DispatchQueue.main.async {
                                        self.isShutdown = (result!["klippy_state"] as? String != "ready")
                                    }
                                    print("serverinfo")
                                    print(result)
                                case .serviceKlipperRestart:
                                    print("restart scheduled")
                                } // switch (id)
                                DispatchQueue.main.async {
                                    self.isConnected = true
                                }
                            } // if let id = json...
                            
                            // If we receive a method string, it is a method.
                            if let method = json["method"] as? String {
                                switch (method) {
                                case "notify_proc_stat_update":
                                    print("received notify_proc_stat_update")
                                default:
                                    print("other unused method received")
                                } // switch (method)...
                                DispatchQueue.main.async {
                                    self.isConnected = true
                                }
                            } // if let method = json...
                        } // if let json = try...
                    } catch {
                        // If the response was not JSON readable,
                        // a connection breaking error has occured
                        DispatchQueue.main.async {
                            self.isConnected = false
                        }
                    } // catch main do
                } // case .string
            } // switch (response)
            self.startReceive()
        } // end of receive closure
    }
    
    // Websocket Operations
    mutating func connect(){
        wsocket = URLSession.shared.webSocketTask(with: URL(string: "ws://\( url )/websocket")!)
        wsocket?.resume()
        queryStatus()
        ping()
        idLookup[nextJSONid] = .serverInfo
        startReceive()
    }
    
    func ping(){
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            wsocket?.sendPing() { result in
                return
            }
            self.ping()
        }
    }
    
    // Helpers for Websocket comms
    
}
