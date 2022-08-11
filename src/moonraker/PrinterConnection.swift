//
//  PrinterConnection.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import Foundation

class PrinterConnection: ObservableObject{
    @Published var configuredName = "No Printer Selected"
    @Published public var alive = false
    
    func setupConnection(name: String){
        configuredName = name
    }
    
    func killConnection(){
        configuredName = "No Printer Selected"
        alive = false
    }
}
