
import SwiftUI

struct VitalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    // MARK: - Navigation State
    @State private var navigateToConsultation = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Header & Search
                VStack(spacing: 16) {
                    headerView
                    
                    // Search Bar
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search by name or specialty...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(uiColor: .systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
                .background(Color(uiColor: .systemBackground))
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 2. Nurse Profile Card (REVERTED to Original Simple Style)
                        nurseProfileCard
                        
                        // 3. Queue Status Card (UPDATED to match HomeView/Screenshot)
                        queueStatusCard
                        
                        // 4. Vitals List
                        vitalsList
                        
                        // 5. Action Button
                        Button {
                            navigateToConsultation = true
                        } label: {
                            Text("Move to Doctor consultation")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
                        }
                        .padding(.top, 10)
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // MARK: - Navigation Destination
            .navigationDestination(isPresented: $navigateToConsultation) {
                DoctorConsultationView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            Text("Vital")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding(.top, 10)
    }
    
 
    private var nurseProfileCard: some View {
            HStack(alignment: .center, spacing: 16) {
                // Avatar
                Image("doctor1") // Ensure asset exists
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    )
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    Text("Nurse Sarah Jenk")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("General Practitioner")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    // Rating Row
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundStyle(.yellow)
                        Text("4.8")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(uiColor: .label))
                        Text("• 120 Reviews")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                // Action Icon
                Button {} label: {
                    Image(systemName: "ellipsis.message.fill")
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .padding(10)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        }
    
  
    private var queueStatusCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header Row
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("DR. Wilson")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.9))
                        Text("2nd Floor, Room 12")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }
                
                Spacer()
                
                // Status Badge
                Text("In Progress")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            // Inner White Info Card
            HStack(spacing: 0) {
                // Position Section
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.teal.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "person.3.fill").font(.headline).foregroundStyle(.teal)
                    }
                    Text("05")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
                
                // Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 1, height: 40)
                
                // Time Section
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.orange.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "hourglass").font(.headline).foregroundStyle(.orange)
                    }
                    Text("15 mins")
                        .font(.title3) // Slightly smaller font for text
                        .bold()
                        .foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Footer
            HStack {
                Text("Please proceed to waiting area")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
                Spacer()
                Button { } label: {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption).fontWeight(.bold)
                    .foregroundStyle(.white)
                }
            }
        }
        .padding(20)
        // Teal/Green Gradient Background
        .background(
            LinearGradient(
                colors: [Color.teal, Color.green.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: Color.teal.opacity(0.3), radius: 10, x: 0, y: 5)
    }
    
    private var vitalsList: some View {
        VStack(spacing: 16) {
            VitalStatCard(title: "Blood Pressure", value: "118/76", unit: "mmHg", icon: "heart.fill", iconColor: .red, badgeText: "Normal", badgeColor: .green, waveType: .regular)
            
            VitalStatCard(title: "Heart Rate", value: "72", unit: "BPM", icon: "waveform.path.ecg", iconColor: .orange, badgeText: "Active", badgeColor: .orange, waveType: .sharp)
            
            VitalStatCard(title: "Respiration", value: "16", unit: "br/min", icon: "lungs.fill", iconColor: .blue, badgeText: "Normal", badgeColor: .green, waveType: .slow)
            
            VitalStatCard(title: "SpO2", value: "98", unit: "%", icon: "drop.fill", iconColor: .red, badgeText: "Optimal", badgeColor: .green, waveType: .regular)
            
            VitalStatCard(title: "Weight", value: "165", unit: "lbs", icon: "scalemass.fill", iconColor: .purple, badgeText: "-2 lbs", badgeColor: .green, waveType: .flat)
            
            VitalStatCard(title: "Body Temp", value: "98.6", unit: "°F", icon: "thermometer.medium", iconColor: .teal, badgeText: nil, badgeColor: .clear, waveType: .regular)
        }
    }
}

// MARK: - Components

struct VitalStatCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let iconColor: Color
    let badgeText: String?
    let badgeColor: Color
    let waveType: WaveType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.subheadline)
                        .foregroundStyle(iconColor)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(uiColor: .label))
                }
                Spacer()
                if let badgeText = badgeText {
                    Text(badgeText)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(badgeColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(badgeColor.opacity(0.1))
                        .clipShape(Capsule())
                }
            }
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value).font(.system(size: 28, weight: .bold)).foregroundStyle(Color(uiColor: .label))
                Text(unit).font(.caption).foregroundStyle(.secondary).padding(.bottom, 4)
            }
            WaveShape(type: waveType)
                .stroke(
                    LinearGradient(colors: [.blue.opacity(0.5), .purple.opacity(0.5)], startPoint: .leading, endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)
                )
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
    }
}

enum WaveType { case regular, sharp, slow, flat }

struct WaveShape: Shape {
    var type: WaveType
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, to: width, by: 5) {
            let relativeX = x / width
            let sine: Double
            switch type {
            case .regular: sine = sin(relativeX * 10 * .pi) * 10
            case .sharp: sine = sin(relativeX * 15 * .pi) * 15 * (x.remainder(dividingBy: 20) == 0 ? 1.5 : 0.5)
            case .slow: sine = sin(relativeX * 6 * .pi) * 8
            case .flat: sine = sin(relativeX * 4 * .pi) * 3
            }
            path.addLine(to: CGPoint(x: x, y: midHeight + sine))
        }
        return path
    }
}

#Preview {
    VitalView()
}
