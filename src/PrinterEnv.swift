//
//  PrinterEnv.swift
//  Plastic
//
//  Created by Charles Pickering on 8/11/22.
//

import Foundation

class PrinterEnv: ObservableObject {
    @Published var configuredPrinters: [Printer] = []
    @Published var selectedPrinter: Printer?
    @Published var printerBeingEdited: Printer?
    
    init() {
        configuredPrinters.append(contentsOf: [Printer(name: "Voron", url: ""),
                                               Printer(name: "CR10", url: ""),
                                               Printer(name: "Delta", url: "")])
        selectedPrinter = configuredPrinters.first
        
    }
    
    private func file() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("printers.dat")
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [self] in
            do {
                let fileURL = try file()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {}
                    return
                }
                let configuredPrinters = try JSONDecoder().decode([Printer].self, from: file.availableData)
                DispatchQueue.main.async {}
            } catch {
                DispatchQueue.main.async {}
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [self] in
            do {
                let data = try JSONEncoder().encode(configuredPrinters)
                let outfile = try file()
                try data.write(to: outfile)
                DispatchQueue.main.async {}
            } catch {
                DispatchQueue.main.async {}
            }
        }
    }
}
