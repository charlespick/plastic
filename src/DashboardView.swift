//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct ReadyDashboardView: View {
    @EnvironmentObject var env: PrinterEnv

    var body: some View {
        VStack {
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            ToolheadView()
            Divider()
            TemperatureButtonView().padding(.horizontal)
            
            MacrosView()
            Spacer()
        }
    }
}

struct DisconnectedDashboardView: View {
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        VStack {
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            Spacer()
            Button("Connect") {
                env.selectedPrinter?.connect()
            }
            Spacer()
        }
    }
}

struct ShutdownDashboardView: View {
    @EnvironmentObject var env: PrinterEnv
    var body: some View {
        VStack {
            StatusBarView(selectedPrinter: env.selectedPrinter ?? Printer(name: "Invalid Printer", url: ""))
            Spacer()
            Button("Restart") {
                env.selectedPrinter?.connect()
            }
            Spacer()

        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DisconnectedDashboardView().environmentObject(PrinterEnv())
            ReadyDashboardView().environmentObject(PrinterEnv())
            ReadyDashboardView().previewDevice("iPhone 8").environmentObject(PrinterEnv())
            ReadyDashboardView().previewDevice("iPhone SE (3rd generation)").environmentObject(PrinterEnv())
        }
    }
}

struct JoggingControlsView: View {
    let height = 50.0
    let width = 60.0
    @State var moveSpeed: CGFloat = 10
    @State var moveDist: CGFloat = 10
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    JogButtonView(systemName: "ellipsis", prominent: false) {
                        env.selectedPrinter?.eStop()
                    }
                    JogButtonView(systemName: "arrow.up.circle", prominent: true, action: {})
                    JogButtonView(systemName: "house", prominent: false, action: {})
                    JogButtonView(systemName: "arrow.up.circle", prominent: true, action: {})
                }
                HStack{
                    JogButtonView(systemName: "arrow.left.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.down.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.right.circle", prominent: true, action: {})
                    JogButtonView(systemName: "arrow.down.circle", prominent: true, action: {})
                }
            }.padding()
                        
            VStack{
                HStack{
                    Text("Speed").font(.caption2).padding(.top, 2.0).frame(width: 60.0)
                    Picker("Speed", selection: $moveSpeed){
                        Text(String(10))
                        Text(String(20))
                    }
                    .pickerStyle(.segmented)
                }.padding(.horizontal)
                HStack{
                    Text("Distance").font(.caption2).padding(.top, 2.0).frame(width: 60.0)
                    Picker("Distance", selection: $moveDist){
                        Text(String(10))
                        Text(String(20))
                        Text(String(30))
                    }
                    .pickerStyle(.segmented)
                }.padding(.horizontal)
            }
            
        }
    }
}

struct TempLineView: View {
    let target: CGFloat
    let current: CGFloat
    let label: String
    let changing: Bool
    
    var body: some View {
        if (changing) {
            (Text("\(label): \(current.formatted()) ") + Text(Image(systemName: "arrow.right")) + Text(" \(target.formatted()) C°")).font(.caption).foregroundColor(.black)
        } else {
            Text("\(label): \(current.formatted()) C° ").font(.caption).foregroundColor(.black)
        }
    }
}

struct StatusBarView: View {
    @ObservedObject var selectedPrinter: Printer
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(selectedPrinter.name ).font(.caption)
                Text(selectedPrinter.isConnected ? "Printer Ready" : "Nor Connected")
                    .padding(.bottom)
            }
            Spacer()
        }
        .background(selectedPrinter.isConnected ? .green : .red)
        .padding(.bottom)
    }
}

struct TemperatureButtonView: View {
    var body: some View {
        Button(action: {}) {
            HStack{
                Label("Tempurture", systemImage: "thermometer")
                Spacer()
                VStack{
                    TempLineView(target: 0.0, current: 23.2, label: "Ex0", changing: false)
                    TempLineView(target: 60.0, current: 32.4, label: "Bed", changing: true)
                }
            }.padding(5.0)
            
        }
        .buttonStyle(.bordered)
    }
}

struct ToolheadPositionView: View {
    @State var xPos: String = "1.0"
    @State var yPos: String = "1.0"
    @State var zPos: String = "1.0"
    
    var body: some View {
        HStack{
            Text("X").font(.caption2)
            TextField("X Position", text: $xPos).textFieldStyle(.roundedBorder)
            Text("Y").font(.caption2)
            TextField("Y Position", text: $yPos).textFieldStyle(.roundedBorder)
            Text("Z").font(.caption2)
            TextField("Z Position", text: $zPos).textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal)
    }
}

struct ToolheadView: View {
    var body: some View {
        VStack{
            Label("Toolhead", systemImage: "move.3d").padding(.bottom, 4.0).font(.caption)
            ToolheadPositionView()
            JoggingControlsView()
        }
    }
}

struct  MacrosView: View {
    let rows = [
        GridItem(.fixed(60), spacing: 10),
        GridItem(.fixed(60), spacing: 0)
    ]

    
    var body: some View {
        VStack{
            Label("Macros", systemImage: "wand.and.stars").padding(.bottom, 4.0).font(.caption)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center, spacing: 10) {
                    MacroButtonView(name: "QGL")
                    MacroButtonView(name: "Hello World")
                    MacroButtonView(name: "Does Something")
                    MacroButtonView(name: "Bark")
                    MacroButtonView(name: "Start Print")
                    
                }
                .padding(.horizontal)
            }
        }
    }
}

struct JogButtonView: View {
    let systemName: String
    let prominent: Bool
    let height = 40.0
    let action: ()->()
    
    var body: some View {
        
        if (prominent){
            Button(action: { action() }){
                HStack {
                    Image(systemName: systemName)
                        .frame(maxWidth: .infinity, maxHeight: height)
                }
            }.buttonStyle(.borderedProminent)
        } else {
            Button(action: { action() }){
                HStack {
                    Image(systemName: systemName)
                        .frame(maxWidth: .infinity, maxHeight: height)
                }
            }.buttonStyle(.bordered)
        }
    }
}

struct MacroButtonView: View {
    let name: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "play.circle").font(.largeTitle)
                Text(name)
                    .frame(minWidth: 120, maxHeight: .infinity)
            }
        }
        .buttonStyle(.borderedProminent)
        
    }
}
