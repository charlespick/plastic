//
//  DashboardExtruderControlsView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/28/22.
//

import SwiftUI

struct DashboardExtruderControlsView: View {
    @StateObject var viewModel: DashboardExtruderControlsViewModel
    
    var body: some View {
        VStack {
            ExtruderValueSliderView(name: "Ext. Multiplier")
            HStack {
                ExtruderSettingButton(prominent: true, systemImage: "scribble.variable", text: "Set Pressure Advance")
                ExtruderSettingButton(prominent: false, systemImage: nil, text: "Set Smooth Time")
            }
            HStack {
                ExtruderSettingButton(prominent: true, systemImage: "gobackward", text: "Set Retract Length")
                ExtruderSettingButton(prominent: false, systemImage: nil, text: "Set Retract Speed")
            }
            HStack {
                ExtruderSettingButton(prominent: false, systemImage: nil, text: "Unretract Extra Length")
                ExtruderSettingButton(prominent: false, systemImage: nil, text: "Unretract Speed")
            }

        }
        .padding()
        .background(.white)
    }
}

struct DashboardExtruderControlsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: .init())
    }
}

struct ExtruderValueSliderView: View {
    let name: String
    @State var value: Int = 0
    var intProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(value)
        }, set: {
            print($0.description)
            value = Int($0)
        })
    }
    var body: some View {
        HStack{
            Text(name)
            Text(value.description)
            Slider(value: intProxy , in: 5.0...100.0, step: 1.0, onEditingChanged: {_ in
                print(value.description)
            })
        }
    }
}

struct ExtruderSettingButton: View {
    let prominent: Bool
    let systemImage: String?
    let text: String
    
    var body: some View {
        if(prominent) {
            Button(action: {}) {
                if let _ = systemImage {
                    Label(text, systemImage: systemImage!)
                        .frame(minHeight: 40)
                } else {
                    Text(text)
                        .frame(minHeight: 40)
                }
            }
            .buttonStyle(.borderedProminent)
        } else {
            Button(action: {}) {
                if let _ = systemImage {
                    Label(text, systemImage: systemImage!)
                        .frame(minHeight: 40)
                } else {
                    Text(text)
                        .frame(minHeight: 40)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}
