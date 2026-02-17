import SwiftUI

struct VitalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            VStack(spacing: 16) {
                headerView
                
                
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
                VStack(spacing: 20) {
                    
                    // 2. Nurse Profile Card
                    nurseProfileCard
                    
                    // 3. Doctor/Location Card (Teal)
                    locationInfoCard
                    
                    // 4. Vitals Grid/List
                    VStack(spacing: 16) {
                        
                        // Blood Pressure
                        VitalStatCard(
                            title: "Blood Pressure",
                            value: "118/76",
                            unit: "mmHg",
                            icon: "heart.fill",
                            iconColor: .red,
                            badgeText: "Normal",
                            badgeColor: .green,
                            waveType: .regular
                        )
                        
                        // Heart Rate
                        VitalStatCard(
                            title: "Heart Rate",
                            value: "72",
                            unit: "BPM",
                            icon: "waveform.path.ecg",
                            iconColor: .orange,
                            badgeText: "Active",
                            badgeColor: .orange,
                            waveType: .sharp
                        )
                        
                        // Respiration
                        VitalStatCard(
                            title: "Respiration",
                            value: "16",
                            unit: "br/min",
                            icon: "lungs.fill",
                            iconColor: .blue,
                            badgeText: "Normal",
                            badgeColor: .green,
                            waveType: .slow
                        )
                        
                        // SpO2
                        VitalStatCard(
                            title: "SpO2",
                            value: "98",
                            unit: "%",
                            icon: "drop.fill",
                            iconColor: .red,
                            badgeText: "Optimal",
                            badgeColor: .green,
                            waveType: .regular
                        )
                        
                        // Weight
                        VitalStatCard(
                            title: "Weight",
                            value: "165",
                            unit: "lbs",
                            icon: "scalemass.fill",
                            iconColor: .purple,
                            badgeText: "-2 lbs",
                            badgeColor: .green,
                            waveType: .flat
                        )
                        
                        // Body Temp
                        VitalStatCard(
                            title: "Body Temp",
                            value: "98.6",
                            unit: "°F",
                            icon: "thermometer.medium",
                            iconColor: .teal,
                            badgeText: nil,
                            badgeColor: .clear,
                            waveType: .regular
                        )
                    }
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
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
        HStack(spacing: 12) {
            Image("doctor1") // Ensure you have this asset or similar
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Nurse Sarah Jenk")
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text("General Practitioner")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text("Visit Date: Oct 24, 2023")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray.opacity(0.5))
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
    }
    
    private var locationInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("DR. Wilson")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                    Text("2nd Floor, Room12")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                }
                Spacer()
            }
            
            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
                Text("9.00 am - 12.00 am")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
            }
            
            Divider().background(Color.white.opacity(0.2))
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.8))
                Spacer()
                Button {} label: {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption).bold()
                    .foregroundStyle(.white)
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color.teal, Color.teal.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.teal.opacity(0.3), radius: 8, y: 4)
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
            
            // Header Row
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
                        .foregroundStyle(badgeColor) // Text color matches theme
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(badgeColor.opacity(0.1))
                        .clipShape(Capsule())
                }
            }
            
            // Value Row
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(unit)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 4)
            }
            
            // Wave Chart
            WaveShape(type: waveType)
                .stroke(
                    LinearGradient(
                        colors: [.blue.opacity(0.5), .purple.opacity(0.5)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
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

// MARK: - Wave Chart Logic

enum WaveType {
    case regular, sharp, slow, flat
}

struct WaveShape: Shape {
    var type: WaveType
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        // Simple algorithm to generate different looking waves
        for x in stride(from: 0, to: width, by: 5) {
            let relativeX = x / width
            let sine: Double
            
            switch type {
            case .regular:
                sine = sin(relativeX * 10 * .pi) * 10
            case .sharp:
                sine = sin(relativeX * 15 * .pi) * 15 * (x.remainder(dividingBy: 20) == 0 ? 1.5 : 0.5)
            case .slow:
                sine = sin(relativeX * 6 * .pi) * 8
            case .flat:
                sine = sin(relativeX * 4 * .pi) * 3
            }
            
            
            let y = midHeight + sine
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return path
    }
}

#Preview {
    VitalView()
}
