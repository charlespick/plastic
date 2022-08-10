//
//  PrinterEditView.swift
//  An edit view for printerConfigs used to form new printer connections of
//  edit existing ones
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrinterEditView: View {
    @Binding var data: PrinterConfig.ModifiedData
    
    var body: some View {
        Form {
            Section(header: Text("Printer Information"), footer: Text("iOS does not support Bonjour. You cannot use hostname.local here.")) {
                TextField("Name", text: $data.name)
                TextField("IP Address or DNS Name", text: $data.url)
            }
        }.onAppear {
        }
    }
}

struct PrinterEditView_Previews: PreviewProvider {
    static var previews: some View {
        PrinterEditView(data: .constant(PrinterConfig.sampleData[0].modifiedData))
    }
}
