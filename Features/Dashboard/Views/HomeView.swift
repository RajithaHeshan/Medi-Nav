
//import SwiftUI
//
//struct HomeView: View {
//    // MARK: - Mock Data
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
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .bottomTrailing) {
//                
//                // 1. Scrollable Content
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 24) {
//                        headerSection
//                        heroCardSection
//                        
//                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
//                            ForEach(menuOptions) { option in
//                                GridCard(option: option)
//                            }
//                        }
//                        
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
//                        
//                        // SPACER FIX: Ensures last item scrolls clearly past the Floating Button
//                        Spacer(minLength: 120)
//                    }
//                    .padding()
//                }
//                
//                // 2. Floating Emergency Button
//                Button {
//                    print("Emergency tapped")
//                } label: {
//                    HStack {
//                        Image(systemName: "phone.fill")
//                        Text("Emergency Help")
//                            .fontWeight(.bold)
//                    }
//                    .padding()
//                    .background(Color.red)
//                    .foregroundStyle(.white)
//                    .clipShape(Capsule())
//                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
//                }
//                .padding(.trailing, 20)
//                // PADDING FIX: Lifts button 90pts to clear the Custom Tab Bar
//                .padding(.bottom, 90)
//            }
//            .background(Color(uiColor: .systemGroupedBackground))
//        }
//    }
//    
//    // MARK: - Subviews
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
//    }
//    
//    private var heroCardSection: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            HStack(alignment: .top) {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("DR. Wilson")
//                        .font(.title2)
//                        .bold()
//                    Text("2nd Floor, Room 12")
//                        .font(.subheadline)
//                        .opacity(0.9)
//                }
//                Spacer()
//                Text("In Progress")
//                    .font(.caption2)
//                    .fontWeight(.bold)
//                    .foregroundStyle(.white)
//                    .padding(.horizontal, 8)
//                    .padding(.vertical, 4)
//                    .background(.white.opacity(0.2))
//                    .clipShape(Capsule())
//            }
//            
//            HStack(spacing: 0) {
//                HStack(spacing: 12) {
//                    ZStack {
//                        Circle().fill(Color.teal.opacity(0.1)).frame(width: 40, height: 40)
//                        Image(systemName: "person.3.fill").foregroundStyle(.teal)
//                    }
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Queue No").font(.caption).foregroundStyle(.secondary)
//                        Text("05").font(.title3).bold().foregroundStyle(Color(uiColor: .label))
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                
//                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 35)
//                
//                HStack(spacing: 12) {
//                    ZStack {
//                        Circle().fill(Color.orange.opacity(0.1)).frame(width: 40, height: 40)
//                        Image(systemName: "hourglass").foregroundStyle(.orange)
//                    }
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Est. Wait").font(.caption).foregroundStyle(.secondary)
//                        Text("15 mins").font(.title3).bold().foregroundStyle(Color(uiColor: .label))
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
//            HStack {
//                Text("Please proceed to waiting area").font(.caption).opacity(0.9)
//                Spacer()
//                Button { } label: {
//                    HStack(spacing: 4) { Text("View Map"); Image(systemName: "arrow.right") }
//                        .font(.caption).bold()
//                }.buttonStyle(.plain)
//            }
//        }
//        .padding(20)
//        .foregroundStyle(.white)
//        .background(LinearGradient(colors: [Color.teal, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
//        .clipShape(RoundedRectangle(cornerRadius: 24))
//        .shadow(color: .green.opacity(0.3), radius: 15, x: 0, y: 8)
//    }
//}
//
//// MARK: - SENIOR DEVELOPER PREVIEW
//// This validates that your component architecture works!
//#Preview {
//    ZStack(alignment: .bottom) {
//        HomeView()
//        
//        // We use your REAL component here, not fake code.
//        // If this works, your folder structure is perfect.
//        CustomTabBar(selectedTab: .constant(.home))
//    }
//}


import SwiftUI

// 1. Data Model for the Carousel Cards
struct ActionCardItem: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let status: String
    let queueNumber: String
    let waitTime: String
    let instruction: String
    let icon: String // "stethoscope" for Doctor, "heart.text.square" for Vitals
}

struct HomeView: View {
    // MARK: - Mock Data
    
    // The "Swipeable" Cards Data
    private let actionCards = [
        ActionCardItem(
            name: "DR. Wilson",
            location: "2nd Floor, Room 12",
            status: "In Progress",
            queueNumber: "05",
            waitTime: "15 mins",
            instruction: "Please proceed to waiting area",
            icon: "stethoscope"
        ),
        ActionCardItem(
            name: "Nurse Sara",
            location: "2nd Floor, Room 13",
            status: "Next",
            queueNumber: "02",
            waitTime: "5 mins",
            instruction: "Please move to next room 12",
            icon: "heart.text.square.fill"
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
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        headerSection
                        
                        // MARK: - CAROUSEL SECTION (Swipeable Cards)
                        TabView {
                            ForEach(actionCards) { card in
                                ActionCardView(card: card)
                                    .padding(.horizontal) // Side padding for the card inside the pager
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always)) // Shows the "Dots" at the bottom
                        .frame(height: 250) // Fixed height for the carousel
                        // Little hack to make the "Dots" visible on white/green
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .onAppear {
                            // Customize the Dot Color to be visible
                            UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
                            UIPageControl.appearance().pageIndicatorTintColor = .systemGray4
                        }
                        
                        // Grid Menu
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(menuOptions) { option in
                                GridCard(option: option)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Visit Progress
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
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.top)
                }
                
                // Floating Button
                Button {
                    print("Emergency tapped")
                } label: {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Emergency Help")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 90)
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
    
    // MARK: - Subviews
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

// MARK: - Reusable Action Card (Doctor & Vitals)
struct ActionCardView: View {
    let card: ActionCardItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header: Name & Status
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
            
            // Stats Row (White Box)
            HStack(spacing: 0) {
                // Queue Section
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.teal.opacity(0.1)).frame(width: 40, height: 40)
                        Image(systemName: "person.3.fill").foregroundStyle(.teal)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Queue No").font(.caption).foregroundStyle(.secondary)
                        Text(card.queueNumber).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 35)
                
                // Time Section
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
            
            // Footer Action
            HStack {
                Text(card.instruction).font(.caption).opacity(0.9)
                Spacer()
                Button { } label: {
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
        // Same Beautiful Gradient for both cards
        .background(
            LinearGradient(colors: [Color.teal, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview
#Preview {
    ZStack(alignment: .bottom) {
        HomeView()
        CustomTabBar(selectedTab: .constant(.home))
    }
}
