import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView(viewModel: .init()).tabItem { Label("Dashboard", systemImage: "desktopcomputer") }
            MachineSettingsView(viewModel: .init()).tabItem { Label("Machine Settings", systemImage: "gearshape.2") }
            FilesView(viewModel: .init()).tabItem { Label("Files", systemImage: "folder") }
            HistoryView(viewModel: .init()).tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
            PrintersView(viewModel: .init()).tabItem { Label("Printers", systemImage: "printer") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
