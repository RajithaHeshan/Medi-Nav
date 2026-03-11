

import SwiftUI

struct ContentView: View {
    @State private var currentTab: AppTab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
           
            TabView(selection: $currentTab) {
                
               
                NavigationStack {
                    HomeView()
                }
                .tag(AppTab.home)
                .toolbar(.hidden, for: .tabBar)
                
               
                NavigationStack {
                    FindDoctorView()
                }
                .tag(AppTab.booking)
                .toolbar(.hidden, for: .tabBar)
                
              
                NavigationStack {
                    ChatView()
                }
                .tag(AppTab.chat)
                .toolbar(.hidden, for: .tabBar)
                
               
                NavigationStack {
                    AccountView()
                }
                .tag(AppTab.account)
                .toolbar(.hidden, for: .tabBar)
            }
            
          
            CustomTabBar(selectedTab: $currentTab)
        }
        
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ContentView()
}
