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
    @Published var isPresentingEditSheet = false
    @Published var isInEditMode = false
    @Published var tempData = Printer.ModifiedData()
    
    init() {
        configuredPrinters.append(contentsOf: [Printer(name: "test", url: "10.7.1.6:7125")])
        selectedPrinter = configuredPrinters.first
        selectedPrinter?.connect()
    }
    
    private func file() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("printers.dat")
    }
    
    func load() async throws {
        let fileURL = try file()
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
            return
        }
        configuredPrinters = try JSONDecoder().decode([Printer].self, from: file.availableData)
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
