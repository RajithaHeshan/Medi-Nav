import SwiftUI

struct HomeView: View {
    // MARK: - Mock Data
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
                // Background
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 1. Header
                        headerSection
                        
                        // 2. Hero Card (Green Card)
                        heroCardSection
                        
                        // 3. Grid Menu
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(menuOptions) { option in
                                GridCard(option: option)
                            }
                        }
                        
                        // 4. Visit Progress
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
                        
                        Spacer(minLength: 80) // Bottom padding
                    }
                    .padding()
                }
                
                // 5. Floating Action Button (Emergency)
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
                    .shadow(radius: 10)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
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
    }
    
    private var heroCardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("DR. Wilson")
                    .font(.title2)
                    .bold()
                Text("2nd Floor, Room 12")
                    .font(.subheadline)
                    .opacity(0.9)
            }
            
            HStack {
                Image(systemName: "clock")
                Text("9.00 am - 12.00 pm")
            }
            .font(.caption)
            .opacity(0.8)
            
            Divider()
                .background(Color.white.opacity(0.3))
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                Spacer()
                // Navigation Link Placeholder
                HStack(spacing: 4) {
                    Text("View Map")
                    Image(systemName: "arrow.right")
                }
                .font(.caption)
                .bold()
            }
        }
        .padding(20)
        .foregroundStyle(.white)
        .background(
            LinearGradient(colors: [Color.teal, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
