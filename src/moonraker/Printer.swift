//
//  Printer.swift
//  Plastic
//
//  Created by Charles Pickering on 8/11/22.
//

import Foundation

class Printer: Identifiable, ObservableObject, Codable {
    
    @Published var name: String
    @Published var id: UUID
    @Published var url: String
    @Published var isConnected = false
    @Published var isShutdown = false
    var wsocket: URLSessionWebSocketTask?
    var nextJSONid = 50
    var idLookup: [Int: MoonrakerMethod] = [:]
    
    // Printer Functions
    func eStop() {
        sendMoonrakerCommand(method: .printerEmergency_stop)
        
    }
    func printerRestart() {
        sendMoonrakerCommand(method: .printerRestart)
    }
    
    // Websocket operations
    func connect(){
        wsocket = URLSession.shared.webSocketTask(with: URL(string: "ws://\( url )/websocket")!)
        wsocket?.resume()
        //queryStatus()
        ping()
        idLookup[nextJSONid] = .serverInfo
        startReceive()
    }
    func sendMoonrakerCommand(method: MoonrakerMethod){
        var payload = Data()
        do {
            payload = try JSONEncoder().encode(JsonRPCRequest(method: method.rawValue, id: nextJSONid))
            idLookup[nextJSONid] = method
            nextJSONid += 1
        }
        catch {}
        wsocket?.send(.data(payload)) { error in
            if error == nil{
                print(error as Any)
            }
        }
    }
    func queryStatus(){
        Task {
            self.sendMoonrakerCommand(method: .printerInfo)
            try await Task.sleep(nanoseconds:10_000_000_000)
            self.queryStatus()
        }
    }
    func startReceive() {
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
                    print(string)
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
                                    self.isShutdown = (result!["klippy_state"] as? String == "shutdown")
                                case .none:
                                    print("no method registered")
                                case .some(.printerRestart):
                                    print("printer restarted")
                                case .some(.printerFirmware_restart):
                                    print("printer firmware restarted")
                                case .some(.serverInfo):
                                    print(result as Any)
                                } // switch (id)
                            } // if let id = json...
                            
                            // If we receive a method string, it is a method.
                            if let method = json["method"] as? String {
                                switch (method) {
                                case "notify_proc_stat_update":
                                    print(json["params"]!)
                                default:
                                    print("other unused method received")
                                } // switch (method)...
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
    func ping(){
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            wsocket?.sendPing() { result in
                return
            }
            self.ping()
        }
    }
    
    // Helpers for: Identifiable
    static func == (lhs: Printer, rhs: Printer) -> Bool {
        return(lhs === rhs)
    }
    
    // Helpers for Websocket comms
    struct JsonRPCRequest: Encodable {
        let jsonrpc = "2.0" //we use a string to override the default json encoding behavior for decimal values.
        let method: String
        let id: Int
    }
    
    // Helpers for persistent storage
    enum CodingKeys: CodingKey {
        case name
        case url
        case uuid
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(UUID.self, forKey: .uuid)
        url = try container.decode(String.self, forKey: .url)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .uuid)
        try container.encode(url, forKey: .url)
    }
    
    // Helpers for instantiation and modification
    init(id: UUID = UUID(), name: String, url: String){
        self.name = name
        self.url = url
        self.id = id
    }
    struct ModifiedData {
        var name: String = ""
        var url: String = ""
    }
    var modifiedData: ModifiedData {
        ModifiedData(name: name, url: url)
    }
    func update(from data: ModifiedData) {
        name = data.name
        url = data.url
    }
    init(data: ModifiedData) {
        id = UUID()
        name = data.name
        url = data.url
    }
}

