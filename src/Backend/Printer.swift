//
//  Printer.swift
//  Plastic
//
//  Created by Charles Pickering on 8/11/22.
//

import Foundation

struct Printer: Identifiable, Codable {
    
    var name: String
    var id: UUID
    var url: String
    
    var isConnected = false
    var isShutdown = false
    var shutdownMessage = ""
    
    var wsocket: URLSessionWebSocketTask?
    var nextJSONid = 50
    var idLookup: [Int: MoonrakerMethod] = [:]
    
    // Helpers for persistent storage
    enum CodingKeys: CodingKey {
        case name
        case url
        case uuid
    }
    init(from decoder: Decoder) throws {
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
    mutating func update(from data: ModifiedData) {
        name = data.name
        url = data.url
    }
    init(data: ModifiedData) {
        id = UUID()
        name = data.name
        url = data.url
    }
}
