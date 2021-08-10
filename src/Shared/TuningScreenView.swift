//
//  TuningScreenView.swift
//  Shared between iOS and macOS
//  Page of the main view that allows tuning of the printer
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct TuningScreenView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Bed Mesh")
                Text("Sensors") //endstops and runout detectors
                Text("Limits") //fans
                Text("Input shaping") //shaper and calibrations
                Text("Pressure advance") //filament library
            }.navigationTitle("Tuning")
        }
    }
}

struct TuningScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TuningScreenView()
    }
}
