
import SwiftUI

struct ContentView: View {

    @State private var currentTab: AppTab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
          
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(AppTab.home)
                    .toolbar(.hidden, for: .tabBar)
                
               
                Text("Booking Feature")
                    .tag(AppTab.booking)
                    .toolbar(.hidden, for: .tabBar)
                
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
