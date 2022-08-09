//
//  PrinterEditView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/8/22.
//

import SwiftUI

struct PrinterEditView: View {
    @Binding var data: PrinterConfig.ModifiedData
    @State private var urlString: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Printer Information"), footer: Text("iOS does not support Bonjour. You cannot use hostname.local here.")) {
                TextField("Name", text: $data.name)
                TextField("IP Address or DNS Name", text: $urlString)
            }
        }.onAppear {
            urlString = data.url
        }
    }
}

struct PrinterEditView_Previews: PreviewProvider {
    static var previews: some View {
        PrinterEditView(data: .constant(PrinterConfig.sampleData[0].modifiedData))
    }
}
