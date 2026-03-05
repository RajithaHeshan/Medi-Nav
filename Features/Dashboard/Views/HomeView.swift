
import SwiftUI
import Combine

struct HomeView: View {
    @State private var searchText = ""
    
    // Navigation States
    @State private var navigateToEmergency = false
    @State private var navigateToDoctors = false // 🔴 Added navigation state for Doctors
    @State private var navigateToMyCare = false // 🔴 Added navigation state for My Care
    
    // Auto-swipe states
    @State private var currentStepIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Main Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        headerSection
                        autoSwipingNextStepSection
                        upcomingAppointmentCard
                        actionGrid
                        visitProgressSection
                        recentActivitySection
                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
                .background(Color(uiColor: .systemGroupedBackground))
                
                // Smooth Swipe Button
                SmoothEmergencyButton {
                    navigateToEmergency = true
                }
                .padding(.trailing, 16)
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            
            // MARK: - Navigation Destinations
            .navigationDestination(isPresented: $navigateToEmergency) {
                EmergencyView()
            }
            .navigationDestination(isPresented: $navigateToDoctors) {
                DoctorServicesView() // 🔴 Connects to your Doctors UI
            }
            .navigationDestination(isPresented: $navigateToMyCare) {
                MyCareView() // 🔴 Connects to your My Care UI
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerSection: some View {
        HStack(spacing: 12) {
            // 🔴 UPDATED: Using your custom application logo
            Image("Ellipse 522")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                // Optional: Add a subtle shadow or stroke if the logo blends into the background
                .overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Hi, S.G.I.K.! 👋")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                HStack(spacing: 4) {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.caption)
                    Text("ID PT-48291")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Button { } label: {
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
    }
    
    private var autoSwipingNextStepSection: some View {
        TabView(selection: $currentStepIndex) {
            NextStepCard(
                title: "Next Step: Visit Doctor",
                time: "10:30 AM",
                personName: "DR. Wickrama",
                personIcon: "person.fill",
                location: "2nd Floor, West Wing",
                queueCount: "5 Queue",
                waitTime: "15 mins",
                themeColor: Color(uiColor: .systemBlue)
            ).tag(0)
            
            NextStepCard(
                title: "Next Step: Vitals Check",
                time: "10:15 AM",
                personName: "Nurse Sarah Jenk",
                personIcon: "cross.case.fill",
                location: "1st Floor, Room 5",
                queueCount: "2 Queue",
                waitTime: "5 mins",
                themeColor: Color(uiColor: .systemBlue)
            ).tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 220)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentStepIndex = (currentStepIndex + 1) % 2
            }
        }
    }
    
    private var upcomingAppointmentCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Upcoming Appointment")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                Spacer()
                Text("10:30 AM")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(uiColor: .systemBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
            
            Text("Friday, Oct 25")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .systemBlue).opacity(0.1))
                        .frame(width: 40, height: 40)
                    Image(systemName: "cross.case.fill").foregroundStyle(Color(uiColor: .systemBlue))
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dr. Sarah Wilson")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text("Cardiologist - Room 12")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            HStack(spacing: 12) {
                Button { } label: {
                    Text("Reschedule")
                        .font(.subheadline).fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                }
                
                Button { } label: {
                    Text("Cancel")
                        .font(.subheadline).fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .systemRed))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(uiColor: .systemRed).opacity(0.05))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color(uiColor: .systemRed).opacity(0.3), lineWidth: 1))
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var actionGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            // 🔴 UPDATED: Wrapped Doctors card in a Button
            Button { navigateToDoctors = true } label: {
                GridMenuCard(title: "Doctors", icon: "stethoscope", color: Color(uiColor: .systemBlue))
            }
            .buttonStyle(PlainButtonStyle())
            
            GridMenuCard(title: "Queue", icon: "list.clipboard.fill", color: Color(uiColor: .systemCyan))
            
            GridMenuCard(title: "Map", icon: "map.fill", color: Color(uiColor: .systemOrange))
            
            // 🔴 UPDATED: Wrapped My Care card in a Button
            Button { navigateToMyCare = true } label: {
                GridMenuCard(title: "My Care", icon: "heart.fill", color: Color(uiColor: .systemRed))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var visitProgressSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Visit Progress")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.bottom, 8)
            
            VStack(spacing: 0) {
                HomeVisitProgressRow(icon: "checkmark", iconColor: .white, iconBg: Color(uiColor: .systemGreen), title: "Check-in", subtitle: "Registration complete", rightText: "08:15 AM", isLast: false, isActive: false)
                HomeVisitProgressRow(icon: "checkmark", iconColor: .white, iconBg: Color(uiColor: .systemGreen), title: "Vitals", subtitle: "BP: 120/80, HR: 72", rightText: "08:30 AM", isLast: false, isActive: false)
                HomeVisitProgressRow(icon: "stethoscope", iconColor: Color(uiColor: .systemGreen), iconBg: Color(uiColor: .systemGray6), title: "Doctor Consultation", subtitle: "Dr. Sarah Wilson - Room 12", rightText: "In Progress", isLast: false, isActive: true, isRightTextPill: true)
                HomeVisitProgressRow(icon: "testtube.2", iconColor: Color(uiColor: .systemGray), iconBg: Color(uiColor: .systemGray6), title: "Lab Work", subtitle: "Blood draw pending", rightText: "", isLast: false, isActive: false, isPending: true)
                HomeVisitProgressRow(icon: "pills.fill", iconColor: Color(uiColor: .systemGray), iconBg: Color(uiColor: .systemGray6), title: "Pharmacy", subtitle: "Prescription pickup", rightText: "", isLast: true, isActive: false, isPending: true)
            }
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var recentActivitySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Activity")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button("View All") { }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
            VStack(spacing: 12) {
                RecentActivityRow(icon: "flask.fill", iconColor: Color(uiColor: .systemBlue), title: "Blood Test Results", subtitle: "Lipid Profile • Yesterday")
                RecentActivityRow(icon: "doc.text.fill", iconColor: Color(uiColor: .systemGreen), title: "New Prescription", subtitle: "Amoxicillin • Oct 22")
            }
        }
    }
}

// MARK: - Reusable Components

struct SmoothEmergencyButton: View {
    let action: () -> Void
    
    @State private var dragOffset: CGFloat = 0
    let minWidth: CGFloat = 56
    let maxWidth: CGFloat = 220
    
    var currentWidth: CGFloat {
        let width = minWidth - dragOffset
        return min(maxWidth, max(minWidth, width))
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .fill(Color(uiColor: .systemRed))
            
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 56, height: 56)
                    Image(systemName: "phone.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                
                Text("Emergency Help")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .fixedSize()
                    .opacity(Double((-dragOffset) / (maxWidth - minWidth)))
            }
            .frame(width: currentWidth, alignment: .leading)
            .clipped()
        }
        .frame(width: currentWidth, height: 56)
        .shadow(color: Color(uiColor: .systemRed).opacity(0.4), radius: 8, x: 0, y: 4)
        .highPriorityGesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        dragOffset = max(value.translation.width, -(maxWidth - minWidth))
                    } else {
                        dragOffset = 0
                    }
                }
                .onEnded { value in
                    let threshold = -(maxWidth - minWidth) * 0.7
                    
                    if dragOffset < threshold {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            dragOffset = -(maxWidth - minWidth)
                        }
                        
                        action()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            dragOffset = 0
                        }
                    } else {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            dragOffset = 0
                        }
                    }
                }
        )
    }
}

struct NextStepCard: View {
    let title: String
    let time: String
    let personName: String
    let personIcon: String
    let location: String
    let queueCount: String
    let waitTime: String
    let themeColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(title).font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                Spacer()
                Text(time).font(.caption).fontWeight(.bold).foregroundStyle(themeColor)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(themeColor.opacity(0.1)).clipShape(Capsule())
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: personIcon).foregroundStyle(themeColor).frame(width: 20)
                    Text(personName).font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(themeColor).frame(width: 20)
                    Text(location).font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            HStack {
                HStack(spacing: 8) { Image(systemName: "person.2.fill").foregroundStyle(themeColor); Text(queueCount).fontWeight(.semibold) }.frame(maxWidth: .infinity)
                Divider().frame(height: 24)
                HStack(spacing: 8) { Image(systemName: "hourglass").foregroundStyle(Color(uiColor: .systemOrange)); Text(waitTime).fontWeight(.semibold) }.frame(maxWidth: .infinity)
            }
            .padding(.vertical, 12).background(Color(uiColor: .systemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 12))
            HStack {
                Text("Please proceed immediately").font(.caption).foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button { } label: { HStack(spacing: 4) { Text("View Map"); Image(systemName: "arrow.right") }.font(.caption).fontWeight(.bold).foregroundStyle(themeColor) }
            }
        }
        .padding(20).background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4).padding(.horizontal, 4)
    }
}

struct GridMenuCard: View {
    let title: String
    let icon: String
    let color: Color
    var body: some View {
        VStack(spacing: 12) {
            ZStack { Circle().fill(color.opacity(0.1)).frame(width: 56, height: 56); Image(systemName: icon).font(.title2).foregroundStyle(color) }
            Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
        }
        .frame(maxWidth: .infinity).padding(.vertical, 20).background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

struct HomeVisitProgressRow: View {
    let icon: String
    let iconColor: Color
    let iconBg: Color
    let title: String
    let subtitle: String
    let rightText: String
    let isLast: Bool
    let isActive: Bool
    var isRightTextPill: Bool = false
    var isPending: Bool = false
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(spacing: 0) {
                ZStack {
                    Circle().fill(iconBg).frame(width: 32, height: 32)
                    if isActive || isPending { Circle().stroke(isActive ? Color(uiColor: .systemGreen) : Color(uiColor: .systemGray4), lineWidth: 2).frame(width: 32, height: 32) }
                    Image(systemName: icon).font(.caption).fontWeight(.bold).foregroundStyle(iconColor)
                }
                if !isLast { Rectangle().fill(Color(uiColor: .systemGray5)).frame(width: 2).frame(minHeight: 40).padding(.vertical, 4) }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(isActive ? Color(uiColor: .systemGreen) : (isPending ? Color(uiColor: .secondaryLabel) : Color(uiColor: .label)))
                Text(subtitle).font(.caption).foregroundStyle(isActive ? Color(uiColor: .systemGreen).opacity(0.8) : Color(uiColor: .secondaryLabel))
            }
            .padding(.top, 6)
            Spacer()
            if !rightText.isEmpty {
                if isRightTextPill { Text(rightText).font(.caption2).fontWeight(.bold).foregroundStyle(Color(uiColor: .systemGray)).padding(.horizontal, 10).padding(.vertical, 4).background(Color(uiColor: .systemGray5)).clipShape(Capsule()).padding(.top, 6) }
                else { HStack(spacing: 4) { Image(systemName: "clock"); Text(rightText) }.font(.caption2).foregroundStyle(Color(uiColor: .secondaryLabel)).padding(.top, 6) }
            }
        }
    }
}

struct RecentActivityRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    var body: some View {
        HStack(spacing: 16) {
            ZStack { Circle().fill(iconColor.opacity(0.1)).frame(width: 40, height: 40); Image(systemName: icon).foregroundStyle(iconColor) }
            VStack(alignment: .leading, spacing: 2) { Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)); Text(subtitle).font(.caption).foregroundStyle(Color(uiColor: .secondaryLabel)) }
            Spacer()
            Image(systemName: "chevron.right").font(.caption).foregroundStyle(Color(uiColor: .systemGray3))
        }
        .padding(16).background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
