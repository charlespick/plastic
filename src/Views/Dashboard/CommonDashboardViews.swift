//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        }
    }
}

struct StatusBarView: View {
    @ObservedObject var selectedPrinter: Printer
    
    var body: some View {
        var isReady = selectedPrinter.isConnected && !selectedPrinter.isShutdown
        
        HStack {
            Spacer()
            VStack {
                Text(selectedPrinter.name ).font(.caption)
                if (!selectedPrinter.isConnected) {
                    Text("Not Connected")
                        .padding(.bottom)
                } else if (selectedPrinter.isShutdown) {
                    Text("Printer Shutdown")
                        .padding(.bottom)
                } else {
                    Text("Printer Ready")
                        .padding(.bottom)
                }
            }
            Spacer()
        }
        .background(isReady ? .green : .red)
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
