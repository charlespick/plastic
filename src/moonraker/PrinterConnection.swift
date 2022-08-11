//
//  PrinterConnection.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import Foundation

class PrinterConnection: ObservableObject {
    public let configuredName: String
    @Published public var alive: Bool
    
    init(name: String, alive: Bool) {
        configuredName = name
        self.alive = alive
        
    }
    
}
