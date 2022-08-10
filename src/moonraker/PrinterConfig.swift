//
//  PrinterConfig.swift
//  Manages the configuration of the printers used
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import Foundation

struct PrinterConfig: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var url: String
    var renderSelected: Bool
    
    init(id: UUID = UUID(), name: String, url: String, renderSelected: Bool) {
        self.id = id
        self.name = name
        self.url = url
        self.renderSelected = renderSelected
    }
    
    // These items support modifying and adding printers at runtime
    struct ModifiedData {
        var name: String = ""
        var url: String = ""
        var renderSelected: Bool = false
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
        renderSelected = data.renderSelected
    }
}

extension PrinterConfig {
    static let sampleData: [PrinterConfig] = [
        PrinterConfig(name: "Voron", url: "voron.makerland.xyz", renderSelected: true),
        PrinterConfig(name: "CR10", url: "192.168.200.5", renderSelected: false)
    ]
}

class PrinterConfigStore: ObservableObject {
    @Published var configuredPrinters: [PrinterConfig] = []
    
    private static func file() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("printers.dat")
        
    }
    
    static func load(completion: @escaping (Result<[PrinterConfig], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try file()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async { completion(.success([])) }
                    return
                }
                let configuredPrinters = try JSONDecoder().decode([PrinterConfig].self, from: file.availableData)
                DispatchQueue.main.async { completion(.success(configuredPrinters)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
    static func save(printerConfigs: [PrinterConfig], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(printerConfigs)
                let outfile = try file()
                try data.write(to: outfile)
                DispatchQueue.main.async { completion(.success(printerConfigs.count)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}
