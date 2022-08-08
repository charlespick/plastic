//
//  PrintersView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/8/22.
//

import SwiftUI

struct PrintersView: View {
    @Binding var printers: [Printer]
    
    var body: some View {
        List{
            ForEach(printers) { printer in
                PrinterCardView(printer: printer)
            }
        }
        .navigationTitle("Printers")
    }
}

struct PrintersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrintersView(printers: .constant(Printer.sampleData))
        }
    }
}

struct PrinterCardView: View {
    let printer: Printer
    
    var body: some View {
        VStack{
            Text(printer.name)
        }
    }
}
