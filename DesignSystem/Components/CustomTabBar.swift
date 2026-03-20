

import SwiftUI

enum AppTab {
    case home
    case booking
    case chat
    case account
}

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    @Binding var homePath: NavigationPath
    

    var onHomeDoubleTap: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color(uiColor: .separator))
            
            HStack(spacing: 0) {
            
                TabBarButton(
                    icon: "house.fill",
                    text: "Home",
                    tab: .home,
                    selectedTab: $selectedTab,
                    homePath: $homePath,
                    onDoubleTap: onHomeDoubleTap
                )
                
                TabBarButton(
                    icon: "calendar.badge.plus",
                    text: "Booking",
                    tab: .booking,
                    selectedTab: $selectedTab,
                    homePath: $homePath
                )
                
                TabBarButton(
                    icon: "bubble.left.and.bubble.right.fill",
                    text: "Chat",
                    tab: .chat,
                    selectedTab: $selectedTab,
                    homePath: $homePath
                )
                .overlay(notificationBadge)
                
            
                TabBarButton(
                    icon: "person.circle.fill",
                    text: "Account",
                    tab: .account,
                    selectedTab: $selectedTab,
                    homePath: $homePath
                )
            }
            .frame(height: 60)
            .background(Color(uiColor: .systemBackground))
        }
    }
    
    private var notificationBadge: some View {
        Text("2")
            .font(.caption2)
            .bold()
            .foregroundStyle(.white)
            .padding(5)
            .background(Color.red)
            .clipShape(Circle())
            .offset(x: 10, y: -10)
    }
}

struct TabBarButton: View {
    let icon: String
    let text: String
    let tab: AppTab
    @Binding var selectedTab: AppTab
    @Binding var homePath: NavigationPath
    
   
    var onDoubleTap: () -> Void = {}
    
    private var iconColor: Color {
        selectedTab == tab ? .blue : .gray
    }
    
    var body: some View {
        Button {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            if selectedTab == tab {
                if tab == .home {
                    homePath = NavigationPath()
                    onDoubleTap()
                }
            } else {
                selectedTab = tab
            }
            
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(iconColor)
                    .symbolEffect(.bounce, value: selectedTab == tab)
                
                Text(text)
                    .font(.caption)
                    .foregroundStyle(iconColor)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.gray.ignoresSafeArea()
        CustomTabBar(selectedTab: .constant(.home), homePath: .constant(NavigationPath()))
    }
}
