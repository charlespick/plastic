//
//  Printer.swift
//  Manages the state and connection of the printers used
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import Foundation

struct Printer: Identifiable, Codable {
    let id: UUID
    var name: String
    var url: String
    
    init(id: UUID = UUID(), name: String, url: String) {
        self.id = id
        self.name = name
        self.url = url
    }
    
    // These items support modifying and adding printers at runtime
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

extension Printer {
    static let sampleData: [Printer] = [
        Printer(name: "Voron", url: "voron.makerland.xyz"),
        Printer(name: "CR10", url: "192.168.200.5")
    ]
}
