//
//  PrinterEditView.swift
//  An edit view for printerConfigs used to form new printer connections of
//  edit existing ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrinterEditView: View {
    @EnvironmentObject var env: AppEnv
    
    var body: some View {
        Form {
            Section(header: Text("Printer Information"), footer: Text("iOS does not support Bonjour. You cannot use hostname.local here.")) {
                TextField("Name", text: $env.tempData.name)
                TextField("IP Address or DNS Name", text: $env.tempData.url)
            }
            if (env.isInEditMode) {
                Button("Delete Printer", role: .destructive) {
                    for (index, printer) in env.configuredPrinters.enumerated() {
                            if (printer === env.printerBeingEdited){
                            env.configuredPrinters.remove(at: index)
                        }
                    }
                    env.isPresentingEditSheet = false
                }
            }
        }
    }
}

struct PrinterEditView_Previews: PreviewProvider {
    static var previews: some View {
        PrinterEditView().environmentObject(AppEnv())
    }
}
