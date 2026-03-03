import SwiftUI

struct ContentView: View {
    // We use the global 'AppTab' enum now
    @State private var currentTab: AppTab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // 1. THE PAGE CONTENT
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(AppTab.home)
                    .toolbar(.hidden, for: .tabBar) // Hide native bar
                
                Text("Chat Feature")
                    .tag(AppTab.chat)
                    .toolbar(.hidden, for: .tabBar)
                
                Text("Account Settings")
                    .tag(AppTab.account)
                    .toolbar(.hidden, for: .tabBar)
            }
            
           
            CustomTabBar(selectedTab: $currentTab)
        }
    }
}

#Preview {
    ContentView()
}
