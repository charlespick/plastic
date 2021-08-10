//
//  JobsScreenView.swift
//  Shared between iOS and macOS
//  Page of the main view that lists jobs that are on the host and availible
//
//  This file may be distributed under the terms of the GNU GPLv3 license.
//

import SwiftUI

struct JobsScreenView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Folder Conts") //ForEach with folder contents
                Text("View Machine History")
            }.navigationTitle("FolderName")
        }
    }
}

struct JobsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        JobsScreenView()
    }
}
