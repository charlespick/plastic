//
//  DashboardView.swift
//  Plastic
//
//  Created by Charles Pickering on 8/10/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var env: PrinterEnv
    
    var body: some View {
        VStack {
            Text(env.selectedPrinter?.name ?? "No Printer Selected")
            
            JoggingControlsView()
            TemperatureButtonView()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView().environmentObject(PrinterEnv())
            DashboardView().previewDevice("iPhone 8").environmentObject(PrinterEnv())
            DashboardView().previewDevice("iPhone SE (3rd generation)").environmentObject(PrinterEnv())
        }
    }
}

struct JoggingControlsView: View {
    let height = 50.0
    let width = 60.0
    
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
            }.padding()
            
        }.buttonStyle(.bordered).padding()
    }
}
