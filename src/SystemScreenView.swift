//
//  SystemScreenView.swift
//  Page of the main view for controlling system-level things related to klipper
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct SystemScreenView: View {
    var body: some View {
        NavigationView {
            List {
                Text("System Statuses") //Temps, usages,
                Text("Controls") //Restarts and view logs
                Text("Configs") //File browser
            }.navigationTitle("Klipper System")
        }
    }
}

struct SystemScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SystemScreenView()
    }
}
