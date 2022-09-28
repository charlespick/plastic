//
//  MachineSettingsView.swift
//  Plastic
//
//  Created by Charles Pickering on 9/27/22.
//

import SwiftUI

struct MachineSettingsView: View {
    @StateObject var viewModel: MachineSettingsViewModel
    
    var body: some View {
        VStack {
            Text("Hello, Machine Settings!")
            Text("Machine Limits")
            Text("fds Settings!")
            Text("Heightmap settings")
            Text("Enter Console button")
            Text("Open in Safari Button")
        }
    }
}

struct MachineSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MachineSettingsView(viewModel: .init())
    }
}
