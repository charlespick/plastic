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
            StatusBarView()
            ToolheadView()
            Divider()
            TemperatureButtonView().padding(.horizontal)
            Spacer()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
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
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {}){
                    Image(systemName: "ellipsis").frame(width: width, height: height)
                }.buttonStyle(.bordered)
                
                Button(action: {}){
                    Image(systemName: "arrow.up.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}){
                    Image(systemName: "house").frame(width: width, height: height)
                }.buttonStyle(.bordered)
                
                Button(action: {}){
                    Image(systemName: "arrow.up.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
            }
            HStack{
                
                Button(action: {}){
                    Image(systemName: "arrow.left.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}){
                    Image(systemName: "arrow.down.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}){
                    Image(systemName: "arrow.right.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
                
                Button(action: {}){
                    Image(systemName: "arrow.down.circle").frame(width: width, height: height)
                }.buttonStyle(.borderedProminent)
            }
            
            VStack{
                Text("Speed").font(.caption2).padding(.top, 2.0)
                Picker("Speed", selection: $moveSpeed){
                    Text(String(10))
                    Text(String(20))
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Text("Distance").font(.caption2).padding(.top, 2.0)
                Picker("Distance", selection: $moveDist){
                    Text(String(10))
                    Text(String(20))
                }
                .pickerStyle(.segmented).padding(.horizontal)
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
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(env.selectedPrinter?.name ?? "No Printer Selected").font(.caption)
                Text("Printer Ready")
                    .padding(.bottom)
            }
            Spacer()
        }
        .background(.yellow)
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
        .padding()
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
