//
//  PrintersView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/8/22.
//

import SwiftUI

struct PrintersView: View {
    @Binding var printers: [Printer]
    @Binding var selectedPrinter: UUID
    @State private var isPresentingEditSheet = false
    @State private var newPrinterData = Printer.ModifiedData()
    
    var body: some View {
        List{
            ForEach(printers) { printer in
                PrinterCardView(printer: printer, selected: (selectedPrinter == printer.id))
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
                                newPrinterData = Printer.ModifiedData()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditSheet = false
                                let newPrinter = Printer(data: newPrinterData)
                                printers.append(newPrinter)
                                newPrinterData = Printer.ModifiedData()
                            }
                        }
                }
                    .navigationTitle("Add Printer")
            }
        }
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(printers: .constant(Printer.sampleData), selectedPrinter: .constant(Printer.sampleData[0].id))
        }
    }
}

struct PrinterCardView: View {
    let printer: Printer
    let selected: Bool
    
    var body: some View {
        HStack{
            if (selected) {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
            
            Text(printer.name)
        }
    }
}
