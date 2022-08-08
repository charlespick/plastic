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
    var url: URL
    
    init(id: UUID = UUID(), name: String, url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}

extension Printer {
    static let sampleData: [Printer] = [
        Printer(name: "Voron", url: URL(string: "voron.makerland.xyz")!),
        Printer(name: "CR10", url: URL(string: "192.168.200.5")!)
    ]
}
