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
    var idLookup: [Int: MoonrakerMessageType] = [:]
    
    // Printer Functions
    func eStop() {
        let request = newJsonRPCRequest(method: "printer.emergency_stop")
        idLookup[nextJSONid] = .printerEmergency_stop
        sendMoonrakerCommand(request: request)
        
    }
    func printerRestart() {
        let request = newJsonRPCRequest(method: "printer.restart")
        idLookup[nextJSONid] = .printerRestart
        sendMoonrakerCommand(request: request)
    }
    
    // Websocket operations
    func connect(){
        wsocket = URLSession.shared.webSocketTask(with: URL(string: "ws://\( url )/websocket")!)
        wsocket?.resume()
        queryStatus()
        ping()
        idLookup[nextJSONid] = .serverInfo
        startReceive()
        
    }
    func sendMoonrakerCommand(request: JsonRPCRequest){
        var payload = Data()
        do {
            payload = try JSONEncoder().encode(request)
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
            self.sendMoonrakerCommand(request: newJsonRPCRequest(method: "server.info"))
            try await Task.sleep(nanoseconds:1_000_000_000)
            self.queryStatus()
        }
    }
    func startReceive() {
        wsocket?.receive() { responce in
            var recivedValidMessage = true
            switch responce {
                
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
                            if (json["jsonrpc"] as? String == "2.0") {
                                
                                //handle messages
                                if let id = json["id"] as? Int {
                                    let result = json["result"] as? [String: Any]
                                    
                                    switch self.idLookup[id]{
                                    case .printerEmergency_stop:
                                        print("Recived shutdown confirmation")
                                        DispatchQueue.main.async {
                                            self.isShutdown = true
                                        }
                                        recivedValidMessage = true
                                    case .printerInfo:
                                        self.isShutdown = (result!["klippy_state"] as? String == "shutdown")
                                        recivedValidMessage = true
                                    case .none:
                                        return
                                    case .some(.printerRestart):
                                        return
                                    case .some(.printerFirmware_restart):
                                        return
                                    case .some(.notifyProcStatUpdate):
                                        return
                                    case .some(.serverInfo):
                                        print(result)
                                        recivedValidMessage = true
                                    }
                                }
                                
                                //handle methods
                                if let method = json["method"] as? String {
                                    switch (method) {
                                    case "notify_proc_stat_update":
                                        //print(json["params"]!)
                                        recivedValidMessage = true
                                    default:
                                        return
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    self.isConnected = true
                                }
                            }
                        }
                    } catch {
                        print("other unknown error occured")
                        DispatchQueue.main.async {
                            self.isConnected = false
                        }
                    }
                    
                default:
                    print("unknown data type")
                    DispatchQueue.main.async {
                        self.isConnected = false
                    }
                }
                
            
            }
            if (recivedValidMessage){
                DispatchQueue.main.async {
                    self.isConnected = true
                }
                self.startReceive()
            } else {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
                self.startReceive()
            }
        }
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
    func newJsonRPCRequest(method: String) -> JsonRPCRequest {
        nextJSONid+=1
        return JsonRPCRequest(method: method, id: nextJSONid)
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

