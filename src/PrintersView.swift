//
//  PrintersView.swift
//  A view that displays configured printers and allows the user to
//  change the selected printer, add new ones, delete, and edit old ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrintersView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        List {
            ForEach(env.configuredPrinters) { printer in
                PrinterCardView(printer: printer)
            }
        }
        .navigationTitle("Printers")
        .toolbar() {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    env.isInEditMode.toggle()
                }) { if (!env.isInEditMode) {
                        Text("Edit")
                    } else {
                        Text("Done").fontWeight(.medium)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    env.tempData = Printer.ModifiedData()
                    env.isPresentingEditSheet = true
                    env.isInEditMode = false }) { Image(systemName: "plus") }
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
            PrintersView().environmentObject(PrinterEnv())
        }
    }
}

struct PrinterCardView: View {
    let printer: Printer
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        Button( action: {
            if (env.isInEditMode) {
                env.printerBeingEdited = printer
                env.tempData = env.printerBeingEdited?.modifiedData ?? Printer.ModifiedData(name: "Error", url: "Error")
                env.isPresentingEditSheet = true
            } else {
                env.selectedPrinter = printer
                env.selectedPrinter?.connect()
            }})
        {
            HStack{
                if (!env.isInEditMode){
                    if (printer == env.selectedPrinter ?? Printer(name: "not a printer", url: "invalidURL")) {
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
