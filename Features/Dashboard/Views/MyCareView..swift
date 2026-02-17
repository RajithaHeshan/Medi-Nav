
import SwiftUI

struct MyCareView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Navigation State
    @State private var showPharmacy = false
    @State private var showLab = false
    @State private var showHistory = false
    @State private var showVitals = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 2. Services Grid (Fixed Layout)
                        servicesGrid
                        
                        // 3. Recent Activity
                        recentActivitySection
                        
                        // 4. Health Score
                        healthScoreCard
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // MARK: - Destinations
            .navigationDestination(isPresented: $showPharmacy) {
                PharmacyView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showLab) {
                LaboratorySampleSubmissionView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showHistory) {
                DoctorConsultationHistoryView().navigationBarBackButtonHidden(true)
            }
            // Add Vital Reports view when ready
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
            Text("My Care")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var servicesGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            
            // 1. Pharmacy
            CareImageGridItem(
                title: "Pharmacy",
                subtitle: "Refill prescriptions",
                imageName: "Pharmacy",
                fallbackIcon: "pills.fill",
                fallbackColor: .blue
            ) { showPharmacy = true }
            
            // 2. Lab Reports
            CareImageGridItem(
                title: "Lab Reports",
                subtitle: "Track your results",
                imageName: "LabReports",
                fallbackIcon: "flask.fill",
                fallbackColor: .purple
            ) { showLab = true }
            
            // 3. Med History
            CareImageGridItem(
                title: "Med History",
                subtitle: "View past records",
                imageName: "medical-reports",
                fallbackIcon: "doc.text.fill",
                fallbackColor: .orange
            ) { showHistory = true }
            
            // 4. Vital Reports
            CareImageGridItem(
                title: "Vital Reports",
                subtitle: "Immunizations",
                imageName: "Vital",
                fallbackIcon: "heart.text.square.fill",
                fallbackColor: .teal
            ) { showVitals = true }
        }
    }
    
    private var recentActivitySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Activity").font(.headline)
                Spacer()
                Button("See All") {}.font(.subheadline).foregroundStyle(.blue)
            }
            
            VStack(spacing: 12) {
                CareActivityRow(
                    title: "General Checkup",
                    subtitle: "Completed Oct 12 • Dr. Smith",
                    icon: "checkmark.circle.fill",
                    iconColor: .green
                )
                CareActivityRow(
                    title: "Blood Test Results",
                    subtitle: "Available Oct 08 • Lab Corp",
                    icon: "flask.fill",
                    iconColor: .blue
                )
                CareActivityRow(
                    title: "Prescription Refill",
                    subtitle: "Processed Oct 05 • CVS",
                    icon: "pills.fill",
                    iconColor: .orange
                )
            }
        }
    }
    
    private var healthScoreCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Health Score").font(.subheadline).fontWeight(.medium).foregroundStyle(.white.opacity(0.9))
                Spacer()
                Image(systemName: "chart.bar.xaxis").foregroundStyle(.white)
            }
            Text("84 / 100").font(.system(size: 34, weight: .bold)).foregroundStyle(.white)
            Text("You've completed all your checkups this quarter. Keep up the healthy habits!")
                .font(.caption).foregroundStyle(.white.opacity(0.9)).lineSpacing(4)
        }
        .padding(20)
        .background(Color.teal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .teal.opacity(0.3), radius: 10, y: 5)
    }
}

// MARK: - FIXED COMPONENT (Hero Image Style)

struct CareImageGridItem: View {
    let title: String
    let subtitle: String
    let imageName: String
    let fallbackIcon: String
    let fallbackColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) { // Spacing 0 ensures image sits flush with text area
                
                // 📸 HERO IMAGE AREA (Top Half)
                GeometryReader { geo in
                    if UIImage(named: imageName) != nil {
                        Image(imageName)
                            .resizable()
                            .scaledToFill() // Fills the width
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipped()
                    } else {
                        // Fallback if image missing
                        ZStack {
                            Color(uiColor: .secondarySystemBackground)
                            Image(systemName: fallbackIcon)
                                .font(.largeTitle)
                                .foregroundStyle(fallbackColor.opacity(0.5))
                        }
                    }
                }
                .frame(height: 90) // Fixed height for image area
                
                // 📝 TEXT AREA (Bottom Half)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(1)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(uiColor: .secondarySystemGroupedBackground))
            }
            .frame(height: 160) // Total Card Height
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(CareScaleButtonStyle())
    }
}

struct CareScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Renamed to avoid conflicts
struct CareActivityRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(iconColor.opacity(0.1)).frame(width: 40, height: 40)
                Image(systemName: icon).font(.subheadline).foregroundStyle(iconColor)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label))
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.gray.opacity(0.4))
        }
        .padding(12)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MyCareView()
}
