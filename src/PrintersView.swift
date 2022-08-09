//
//  PrintersView.swift
//  A view that displays configured printers and allows the user to
//  change the selected printer, add new ones, delete, and edit old ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrintersView: View {
    @Binding var printers: [PrinterConfig]
    @State private var isPresentingEditSheet = false
    @State private var newPrinterData = PrinterConfig.ModifiedData()
    @Environment(\.scenePhase) private var scenePhase
    let saveCall: ()->Void
    
    var body: some View {
        List{
            ForEach(printers) { printer in
                PrinterCardView(printer: printer)
            }
        }
        .navigationTitle("Printers")
        .toolbar() {
            Button(action: { isPresentingEditSheet = true }) { Image(systemName: "plus") }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            NavigationView {
                PrinterEditView(data: $newPrinterData)
                    .toolbar() {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditSheet = false
                                newPrinterData = PrinterConfig.ModifiedData()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditSheet = false
                                let newPrinter = PrinterConfig(data: newPrinterData)
                                printers.append(newPrinter)
                                newPrinterData = PrinterConfig.ModifiedData()
                            }
                        }
                }
                    .navigationTitle("Add Printer")
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveCall() }
        }
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(printers: .constant(PrinterConfig.sampleData), saveCall: {})
        }
    }
}

struct PrinterCardView: View {
    let printer: PrinterConfig
    var body: some View {
        HStack{
            if (printer.renderSelected) {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
            
            Text(printer.name)
        }
    }
}
