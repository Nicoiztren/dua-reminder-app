import SwiftUI

/// Entry point for the Dua Reminder App.
/// Wraps the main DuaListView in a NavigationView.
struct ContentView: View {
    var body: some View {
        NavigationView {
            DuaListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
