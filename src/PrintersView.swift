//
//  PrintersView.swift
//  A view that displays configured printers and allows the user to
//  change the selected printer, add new ones, delete, and edit old ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrintersView: View {
    @Binding var isPresentingEditSheet: Bool
    @Binding  var isInEditMode: Bool
    @Binding var newPrinterData: Printer.ModifiedData
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        List {
            ForEach(Array(env.configuredPrinters.enumerated()), id: \.element) { index, printer in
                PrinterCardView(printer: printer, isInEditMode: isInEditMode) }
        }
        .navigationTitle("Printers")
        .toolbar() {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: { isInEditMode.toggle() }) { if (!isInEditMode){ Text("Edit") } else { Text("Done").fontWeight(.medium) } } }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    newPrinterData = Printer.ModifiedData()
                    isPresentingEditSheet = true
                    isInEditMode = false }) { Image(systemName: "plus") }
            }
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { env.save() }
        }
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(isPresentingEditSheet: .constant(false), isInEditMode: .constant(false), newPrinterData: .constant(Printer.ModifiedData()))
        }
    }
}

struct PrinterCardView: View {
    let printer: Printer
    let isInEditMode: Bool
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        Button( action: {
            if (isInEditMode) {
                env.printerBeingEdited = printer
            } else {
                env.selectedPrinter = printer }}){
            HStack{
                if (!isInEditMode){
                    if (printer == env.selectedPrinter) {
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
