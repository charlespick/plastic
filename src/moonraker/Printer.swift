//
//  Printer.swift
//  Plastic
//
//  Created by Charles Pickering on 8/11/22.
//

import Foundation

class Printer: Identifiable, ObservableObject, Codable, Hashable {
    static func == (lhs: Printer, rhs: Printer) -> Bool {
        return(lhs === rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var name: String
    @Published var id: UUID
    @Published var url: String
    
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
