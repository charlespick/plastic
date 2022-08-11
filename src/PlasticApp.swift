//
//  PlasticApp.swift
//  App kernal and bearer of app state
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI
import CoreData

@main
struct PlasticApp: App {
    @StateObject private var store = PrinterConfigStore()
    @StateObject private var printer = PrinterConnection()
    @State private var selectedPrinterIndex: Int = -1
    
    func selectAction(uuid: UUID) {
        if (selectedPrinterIndex != -1) {
            store.configuredPrinters[selectedPrinterIndex].renderSelected = false
        }
        for (index, printer) in store.configuredPrinters.enumerated() {
            if (printer.id == uuid) {
                store.configuredPrinters[index].renderSelected = true
                selectedPrinterIndex = index
                self.printer.setupConnection(name: printer.name)            }
        }
        
    }
    
    func saveCall() {
        PrinterConfigStore.save(printerConfigs: store.configuredPrinters) { result in
            if case .failure(let error) = result { fatalError(error.localizedDescription) }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(printer: printer, printers: $store.configuredPrinters, saveCallForPrinters: saveCall, selectActionForPrinters: selectAction(uuid:))
            .onAppear {
                PrinterConfigStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let printers):
                        // The storage layer is holding the configured printers and processing the data but not transfering it internally for now. I will consider condencing this at a later time.
                        store.configuredPrinters = printers
                    }
                    for (index, printer) in store.configuredPrinters.enumerated() {
                        if (printer.renderSelected == true) {
                            selectedPrinterIndex = index
                        }
                    }
                }
            }
        }
    }
}
