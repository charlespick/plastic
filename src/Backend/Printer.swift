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
    @Published var shutdownMessage = ""
    
    var wsocket: URLSessionWebSocketTask?
    var nextJSONid = 50
    var idLookup: [Int: MoonrakerMethod] = [:]
    
    // Helpers for: Identifiable
    static func == (lhs: Printer, rhs: Printer) -> Bool {
        return(lhs === rhs)
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
