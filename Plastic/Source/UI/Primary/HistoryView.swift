import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
        Text("A History Explorer")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: .init())
    }
}
