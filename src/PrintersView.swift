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
    @State private var isInEditMode = false
    @State private var newPrinterData = PrinterConfig.ModifiedData()
    @Environment(\.scenePhase) private var scenePhase
    let saveCall: ()->Void
    let selectAction: (_ printerID: UUID)->Void
    
    var body: some View {
        List{
            ForEach(printers) { printer in
                PrinterCardView(printer: printer, selectAction: { printerID in
                    if (!isInEditMode){
                        selectAction(printerID)
                    } else {
                        newPrinterData = printer.modifiedData
                        isPresentingEditSheet = true
                    }
                    
                }, isInEditMode: isInEditMode)
            }
        }
        .navigationTitle("Printers")
        .toolbar() {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: { isInEditMode.toggle() }) {
                    if (!isInEditMode){
                        Text("Edit")
                    } else {
                        Text("Done")
                            .fontWeight(.medium)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isPresentingEditSheet = true; isInEditMode = false }) { Image(systemName: "plus") }
            }
            
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
                    .navigationTitle(isInEditMode ? "Edit Printer":"Add Printer")
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
            PrintersView(printers: .constant(PrinterConfig.sampleData), saveCall: {}, selectAction: { printerID in })
        }
    }
}

struct PrinterCardView: View {
    let printer: PrinterConfig
    let selectAction: (_ printerID: UUID)->Void
    let isInEditMode: Bool
    
    var body: some View {
        Button( action: { selectAction(printer.id) } ) {
            HStack{
                if (!isInEditMode){
                    if (printer.renderSelected) {
                        Image(systemName: "checkmark.circle.fill")
                    } else {
                        Image(systemName: "circle")
                    }
                }
                Text(printer.name)
            }
        }
    }
}
