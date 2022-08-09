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
    @State private var selectedPrinterIndex: Int = -1
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PrintersView(printers: $store.configuredPrinters) {
                    PrinterConfigStore.save(printerConfigs: store.configuredPrinters) { result in
                        if case .failure(let error) = result { fatalError(error.localizedDescription) }
                    }
                } selectAction: { uuid in
                    if (selectedPrinterIndex != -1) {
                        store.configuredPrinters[selectedPrinterIndex].renderSelected = false
                    }
                    for (index, printer) in store.configuredPrinters.enumerated() {
                        if (printer.id == uuid) {
                            store.configuredPrinters[index].renderSelected = true
                            selectedPrinterIndex = index
                            return
                        }
                    }
                }
            }
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

struct Macro: Identifiable {
    var id: Int
    let name: String
}
