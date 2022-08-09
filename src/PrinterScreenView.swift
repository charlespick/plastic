//
//  PrinterScreenView.swift
//  Page of the main view that shows status and controls the printer
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct PrinterScreenView: View {
    var macros: [Macro] = [Macro( id: 1, name: "Start_Print"), Macro( id: 2, name: "Stop_Print")]
    var body: some View {
        NavigationView {
        }
    }
}

struct PrinterScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PrinterScreenView(macros: [Macro( id: 1, name: "Start_Print"), Macro( id: 2, name: "Stop_Print")])
    }
}

struct ControlBlock: View {
    let macros: [Macro]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Control")
            HStack {
                VStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "arrow.up") }
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "arrow.left") }
                        Button(action: {}) { Image(systemName: "house") }
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "arrow.right") }
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "arrow.down") }
                }
                VStack{
                    Button(action: {}) { Image(systemName: "arrow.up") }

                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "house") }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { Image(systemName: "arrow.down") }
                }
            }
            HStack {
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                TextField("Placeholder", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            HStack{
                VStack {
                    Label("X", systemImage: "arrow.left.and.right")
                    TextField("Xsdfsdf", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                }
                VStack {
                    Label("Y", systemImage: "arrow.up.and.down")
                    TextField("Xsdfsdf", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                }
                VStack {
                    Label("Z", systemImage: "arrow.up.arrow.down")
                    TextField("Xsdfsdf", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                }
            }
            HStack {
                VStack{
                    VStack {
                        Text("Filament Distance")
                        TextField("Xsdfsdf", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    }
                    VStack {
                        Text("Feedrate")
                        TextField("Xsdfsdf", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    }
                }
                VStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        HStack{
                            Text("Extrude")
                            Image(systemName: "arrow.turn.right.down")
                        }
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        HStack{
                            Text("Retract")
                            Image(systemName: "arrow.turn.left.up")
                        }
                    }
                }
            }
            HStack{
                Text("Speed")
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                Text("Value")
            }
            HStack{
                Text("Flow")
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                Text("Value")
            }
            ScrollView {
                HStack{
                    ForEach(macros) { macro in
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text(macro.name)
                        }
                    }
                }
            }
        }
    }
}
// Not sure what to do with this rn
//struct ExtractedView: View {
//    var body: some View {
//        List {
//            ControlBlock(macros: macros) //with camera thumnail
//            //movement and macros
//            Text("Tempuratures") //graph and settings
//            Text("Fans") //fans
//            Text("Accesories") //neopixels, bltouch, other outputs
//        }.navigationTitle("PrinterName").navigationBarItems(leading: Button(action: {}){
//            Text("Switch Instance")
//        }, trailing: Button(action: {}){
//            Image(systemName: "exclamationmark.octagon.fill")
//        })
//    }
//}
