//import SwiftUI
//
//
//struct ActionCardItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let location: String
//    let status: String
//    let queueNumber: String
//    let waitTime: String
//    let instruction: String
//    let icon: String
//    let colorStart: Color
//    let colorEnd: Color
//}
//
//// MARK: - 2. Main View
//struct HomeView: View {
//    @State private var showEmergencyScreen = false
//    
//    // MARK: - Mock Data
//    private let actionCards = [
//        ActionCardItem(
//            name: "DR. Wilson",
//            location: "2nd Floor, Room 12",
//            status: "In Progress",
//            queueNumber: "05",
//            waitTime: "15 mins",
//            instruction: "Please proceed to waiting area",
//            icon: "stethoscope",
//            colorStart: .teal,
//            colorEnd: .green
//        ),
//        ActionCardItem(
//            name: "Nurse Sara",
//            location: "2nd Floor, Room 13",
//            status: "Next",
//            queueNumber: "02",
//            waitTime: "5 mins",
//            instruction: "Please move to next room 12",
//            icon: "heart.text.square.fill",
//            colorStart: .blue,
//            colorEnd: .purple
//        )
//    ]
//    
//    private let menuOptions = [
//        MenuOption(title: "Doctors", imageName: "doc", systemIcon: "person.fill.viewfinder"),
//        MenuOption(title: "Queue", imageName: "queue", systemIcon: "clock.fill"),
//        MenuOption(title: "Map", imageName: "map", systemIcon: "map.fill"),
//        MenuOption(title: "My Care", imageName: "care", systemIcon: "heart.text.square.fill")
//    ]
//    
//    private let visitTimeline = [
//        VisitStep(title: "Check-in", subtitle: "Registration complete", time: "09:15 AM", status: .completed),
//        VisitStep(title: "Vitals", subtitle: "BP: 120/80, HR: 72", time: nil, status: .completed),
//        VisitStep(title: "Doctor Consultation", subtitle: "Dr. Sarah Wilson - Room 12", time: "In Progress", status: .current),
//        VisitStep(title: "Lab Work", subtitle: "Blood draw pending", time: nil, status: .pending),
//        VisitStep(title: "Pharmacy", subtitle: "Prescription pickup", time: nil, status: .pending)
//    ]
//    
//    // MARK: - Body
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .bottomTrailing) {
//                
//                // A. Scrollable Content
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 24) {
//                        
//                        headerSection
//                        
//                        // B. Swipeable Carousel
//                        TabView {
//                            ForEach(actionCards) { card in
//                                ActionCardView(card: card)
//                                    .padding(.horizontal)
//                            }
//                        }
//                        .tabViewStyle(.page(indexDisplayMode: .always))
//                        .frame(height: 250)
//                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
//                        .onAppear {
//                            UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
//                            UIPageControl.appearance().pageIndicatorTintColor = .systemGray4
//                        }
//                        
//                        // C. Grid Menu
//                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
//                            ForEach(menuOptions) { option in
//                                GridCard(option: option)
//                            }
//                        }
//                        .padding(.horizontal)
//                        
//                        // D. Visit Progress List
//                        VStack(alignment: .leading, spacing: 20) {
//                            Text("Visit Progress")
//                                .font(.title3)
//                                .bold()
//                            
//                            VStack(alignment: .leading, spacing: 0) {
//                                ForEach(Array(visitTimeline.enumerated()), id: \.element.id) { index, step in
//                                    TimelineRow(step: step, isLast: index == visitTimeline.count - 1)
//                                }
//                            }
//                        }
//                        .padding(20)
//                        .background(Color(uiColor: .systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .padding(.horizontal)
//                        
//                        // E. Bottom Spacer
//                        Spacer(minLength: 140)
//                    }
//                    .padding(.top)
//                }
//                
//                
//                SmartEmergencyButton {
//                  // Navigate to the Emergency Screen
//                    showEmergencyScreen = true
//                }
//                .padding(.trailing, 20)
//                .padding(.bottom, 90)
//            }
//            .background(Color(uiColor: .systemGroupedBackground))
//        }
//    }
//    
//    // MARK: - Header Subview
//    private var headerSection: some View {
//        HStack {
//            Circle()
//                .fill(Color.blue.opacity(0.1))
//                .frame(width: 50, height: 50)
//                .overlay(Text("SG").bold().foregroundStyle(.blue))
//            
//            VStack(alignment: .leading) {
//                Text("Hi, S.G.I.K.! 👋")
//                    .font(.title3)
//                    .bold()
//                Text("ID PT-48291")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//            }
//            Spacer()
//            Image(systemName: "bell.badge.fill")
//                .font(.title2)
//                .foregroundStyle(Color(uiColor: .label))
//        }
//        .padding(.horizontal)
//    }
//}
//
//// MARK: - 3. Reusable Card Component
//struct ActionCardView: View {
//    let card: ActionCardItem
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            // Header
//            HStack(alignment: .top) {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(card.name)
//                        .font(.title2)
//                        .bold()
//                    HStack(spacing: 4) {
//                        Image(systemName: "location.fill")
//                            .font(.caption)
//                        Text(card.location)
//                            .font(.subheadline)
//                    }
//                    .opacity(0.9)
//                }
//                Spacer()
//                Text(card.status)
//                    .font(.caption2)
//                    .fontWeight(.bold)
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 8)
//                    .padding(.vertical, 4)
//                    .background(.white.opacity(0.2))
//                    .clipShape(Capsule())
//            }
//            
//            // Stats Row
//            HStack(spacing: 0) {
//                // Queue Info
//                HStack(spacing: 12) {
//                    ZStack {
//                        Circle().fill(card.colorStart.opacity(0.2)).frame(width: 40, height: 40)
//                        Image(systemName: "person.3.fill").foregroundStyle(card.colorStart)
//                    }
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Queue No").font(.caption).foregroundStyle(.secondary)
//                        Text(card.queueNumber).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                
//                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 35)
//                
//                // Time Info
//                HStack(spacing: 12) {
//                    ZStack {
//                        Circle().fill(Color.orange.opacity(0.1)).frame(width: 40, height: 40)
//                        Image(systemName: "hourglass").foregroundStyle(.orange)
//                    }
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Est. Wait").font(.caption).foregroundStyle(.secondary)
//                        Text(card.waitTime).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 16)
//            }
//            .padding(12)
//            .background(Color(uiColor: .systemBackground))
//            .clipShape(RoundedRectangle(cornerRadius: 16))
//            
//            Divider().background(Color.white.opacity(0.3))
//            
//            // Footer
//            HStack {
//                Text(card.instruction).font(.caption).opacity(0.9)
//                Spacer()
//                Button {
//                    // Map Action
//                } label: {
//                    HStack(spacing: 4) {
//                        Text("View Map")
//                        Image(systemName: "arrow.right")
//                    }
//                    .font(.caption).bold()
//                }.buttonStyle(.plain)
//            }
//        }
//        .padding(20)
//        .foregroundStyle(.white)
//        .background(
//            LinearGradient(colors: [card.colorStart, card.colorEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
//        )
//        .clipShape(RoundedRectangle(cornerRadius: 24))
//        .shadow(color: card.colorEnd.opacity(0.3), radius: 10, x: 0, y: 5)
//    }
//}
//
//
//// MARK: - Preview
//#Preview {
//    ZStack(alignment: .bottom) {
//        HomeView()
//        CustomTabBar(selectedTab: .constant(.home))
//    }
//}
 
import SwiftUI

// MARK: - 1. Data Models
struct ActionCardItem: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let status: String
    let queueNumber: String
    let waitTime: String
    let instruction: String
    let icon: String
    let colorStart: Color
    let colorEnd: Color
}


struct HomeView: View {
    
    
    @State private var showEmergencyScreen = false
    
   
    private let actionCards = [
        ActionCardItem(
            name: "DR. Wilson",
            location: "2nd Floor, Room 12",
            status: "In Progress",
            queueNumber: "05",
            waitTime: "15 mins",
            instruction: "Please proceed to waiting area",
            icon: "stethoscope",
            colorStart: .teal,
            colorEnd: .green
        ),
        ActionCardItem(
            name: "Nurse Sara",
            location: "2nd Floor, Room 13",
            status: "Next",
            queueNumber: "02",
            waitTime: "5 mins",
            instruction: "Please move to next room 12",
            icon: "heart.text.square.fill",
            colorStart: .blue,
            colorEnd: .purple
        )
    ]
    
    private let menuOptions = [
        MenuOption(title: "Doctors", imageName: "doc", systemIcon: "person.fill.viewfinder"),
        MenuOption(title: "Queue", imageName: "queue", systemIcon: "clock.fill"),
        MenuOption(title: "Map", imageName: "map", systemIcon: "map.fill"),
        MenuOption(title: "My Care", imageName: "care", systemIcon: "heart.text.square.fill")
    ]
    
    private let visitTimeline = [
        VisitStep(title: "Check-in", subtitle: "Registration complete", time: "09:15 AM", status: .completed),
        VisitStep(title: "Vitals", subtitle: "BP: 120/80, HR: 72", time: nil, status: .completed),
        VisitStep(title: "Doctor Consultation", subtitle: "Dr. Sarah Wilson - Room 12", time: "In Progress", status: .current),
        VisitStep(title: "Lab Work", subtitle: "Blood draw pending", time: nil, status: .pending),
        VisitStep(title: "Pharmacy", subtitle: "Prescription pickup", time: nil, status: .pending)
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                // A. Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        headerSection
                        
                        // B. Swipeable Carousel
                        TabView {
                            ForEach(actionCards) { card in
                                ActionCardView(card: card)
                                    .padding(.horizontal)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 250)
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .onAppear {
                            UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
                            UIPageControl.appearance().pageIndicatorTintColor = .systemGray4
                        }
                        
                        // C. Grid Menu
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(menuOptions) { option in
                                GridCard(option: option)
                            }
                        }
                        .padding(.horizontal)
                        
                        // D. Visit Progress List
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Visit Progress")
                                .font(.title3)
                                .bold()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(Array(visitTimeline.enumerated()), id: \.element.id) { index, step in
                                    TimelineRow(step: step, isLast: index == visitTimeline.count - 1)
                                }
                            }
                        }
                        .padding(20)
                        .background(Color(uiColor: .systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                        
                        // E. Bottom Spacer
                        Spacer(minLength: 140)
                    }
                    .padding(.top)
                }
                
                // F. Smart Emergency Button
                SmartEmergencyButton {
                    // 🔴 2. TRIGGER: When tapped, change state to true
                    showEmergencyScreen = true
                }
                .padding(.trailing, 20)
                .padding(.bottom, 90)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            // 🔴 3. DESTINATION: Tell the app where to go
            .navigationDestination(isPresented: $showEmergencyScreen) {
                EmergencyView()
                    .navigationBarBackButtonHidden(true) // We use our custom back button
            }
        }
    }
    
    // MARK: - Header Subview
    private var headerSection: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(Text("SG").bold().foregroundStyle(.blue))
            
            VStack(alignment: .leading) {
                Text("Hi, S.G.I.K.! 👋")
                    .font(.title3)
                    .bold()
                Text("ID PT-48291")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "bell.badge.fill")
                .font(.title2)
                .foregroundStyle(Color(uiColor: .label))
        }
        .padding(.horizontal)
    }
}

// MARK: - 3. Reusable Card Component
struct ActionCardView: View {
    let card: ActionCardItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.name)
                        .font(.title2)
                        .bold()
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text(card.location)
                            .font(.subheadline)
                    }
                    .opacity(0.9)
                }
                Spacer()
                Text(card.status)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            // Stats Row
            HStack(spacing: 0) {
                // Queue Info
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(card.colorStart.opacity(0.2)).frame(width: 40, height: 40)
                        Image(systemName: "person.3.fill").foregroundStyle(card.colorStart)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Queue No").font(.caption).foregroundStyle(.secondary)
                        Text(card.queueNumber).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 35)
                
                // Time Info
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.orange.opacity(0.1)).frame(width: 40, height: 40)
                        Image(systemName: "hourglass").foregroundStyle(.orange)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Est. Wait").font(.caption).foregroundStyle(.secondary)
                        Text(card.waitTime).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            }
            .padding(12)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Divider().background(Color.white.opacity(0.3))
            
            // Footer
            HStack {
                Text(card.instruction).font(.caption).opacity(0.9)
                Spacer()
                Button {
                    // Map Action
                } label: {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption).bold()
                }.buttonStyle(.plain)
            }
        }
        .padding(20)
        .foregroundStyle(.white)
        .background(
            LinearGradient(colors: [card.colorStart, card.colorEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: card.colorEnd.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}


#Preview {
    ZStack(alignment: .bottom) {
        HomeView()
        CustomTabBar(selectedTab: .constant(.home))
    }
}
