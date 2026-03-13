import SwiftUI

struct AmbulanceTrackingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
               
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                
                        statusHeaderSection
                        
                       
                        ambulanceInfoCard
                        
                        
                        trackingTimelineCard
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
   
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemBackground))
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.blue)
                        .offset(x: -1.5)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
    
    private var statusHeaderSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.green)
            }
            
            VStack(spacing: 8) {
                Text("Help is on the way")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text("Our Emergency Medical Team has been\nnotified and is moving to your location.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                    .padding(.horizontal, 20)
            }
        }
    }
    
    private var ambulanceInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            InfoRow(icon: "cross.case.fill", iconColor: .orange, text: "Ambulance 7124")
            InfoRow(icon: "hourglass", iconColor: .brown, text: "Estimate time 15 min")
            InfoRow(icon: "person.fill", iconColor: .blue, text: "Angeala (Nurse)")
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var trackingTimelineCard: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // Header & Call Button
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ambulance #7124")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("Paramedic: Robert Wilson")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
                
                Button(action: {
                   
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green.opacity(0.15))
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "phone.fill")
                            .font(.title3)
                            .foregroundStyle(Color.green)
                    }
                }
            }
            
          
            VStack(alignment: .leading, spacing: 0) {
                TimelineStep(
                    isCompleted: true,
                    isLast: false,
                    title: "Ambulance Dispatched",
                    subtitle: "10:42 AM",
                    iconColor: .green
                )
                
               
                TimelineStep(
                    isCompleted: false,
                    isActive: true,
                    isLast: false,
                    title: "On the way your location",
                    subtitle: "Currently 3.2 km away",
                    iconColor: .blue
                )
                
                TimelineStep(
                    isCompleted: false,
                    isLast: true,
                    title: "Arriving at your location",
                    subtitle: "",
                    iconColor: Color(uiColor: .systemGray4)
                )
            }
            .padding(.top, 8)
            
            
            horizontalTracker
                .padding(.top, 16)
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var horizontalTracker: some View {
        HStack(spacing: 0) {
            TrackerDot(title: "Received", status: .completed)
            TrackerLine(status: .completed)
            TrackerDot(title: "Dispatched", status: .completed)
            TrackerLine(status: .active)
            TrackerDot(title: "En Route", status: .active)
            TrackerLine(status: .pending)
            TrackerDot(title: "Arrived", status: .pending)
        }
    }
}



struct InfoRow: View {
    let icon: String
    let iconColor: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(iconColor)
                .frame(width: 24) // Ensures icons align perfectly
            
            Text(text)
                .font(.headline)
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}


struct TimelineStep: View {
    var isCompleted: Bool = false
    var isActive: Bool = false
    var isLast: Bool = false
    let title: String
    let subtitle: String
    let iconColor: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Line & Dot Graphic
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(isActive ? iconColor.opacity(0.2) : Color.clear)
                        .frame(width: 24, height: 24)
                    
                    if isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(iconColor)
                            .font(.system(size: 20))
                            .background(Circle().fill(.white))
                    } else if isActive {
                        Circle()
                            .stroke(iconColor, lineWidth: 4)
                            .frame(width: 14, height: 14)
                            .background(Circle().fill(.white))
                    } else {
                        Circle()
                            .fill(iconColor)
                            .frame(width: 12, height: 12)
                    }
                }
                
                if !isLast {
                    Rectangle()
                        .fill(isCompleted ? iconColor : Color(uiColor: .systemGray5))
                        .frame(width: 2, height: 40)
                }
            }
           
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(isActive || isCompleted ? .bold : .semibold)
                    .foregroundStyle(isActive || isCompleted ? Color(uiColor: .label) : Color(uiColor: .systemGray3))
                
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(isActive ? iconColor : Color(uiColor: .secondaryLabel))
                }
            }
            .padding(.top, 2)
            
            Spacer()
        }
    }
}


enum TrackerStatus {
    case completed, active, pending
}

struct TrackerDot: View {
    let title: String
    let status: TrackerStatus
    
    var body: some View {
        VStack(spacing: 8) {
            if status == .active {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(Color.green)
            } else {
                Circle()
                    .fill(status == .completed ? Color.green : Color(uiColor: .systemGray4))
                    .frame(width: 10, height: 10)
            }
            
            Text(title)
                .font(.system(size: 10))
                .fontWeight(status == .active ? .bold : .semibold)
                .foregroundStyle(status == .pending ? Color(uiColor: .systemGray3) : Color(uiColor: .label))
        }
        .frame(maxWidth: .infinity)
    }
}

struct TrackerLine: View {
    let status: TrackerStatus
    
    var body: some View {
        Rectangle()
            .fill(status == .completed || status == .active ? Color.green : Color(uiColor: .systemGray4))
            .frame(height: 2)
            .padding(.bottom, 16)
    }
}

#Preview {
    NavigationStack {
        AmbulanceTrackingView()
    }
}
