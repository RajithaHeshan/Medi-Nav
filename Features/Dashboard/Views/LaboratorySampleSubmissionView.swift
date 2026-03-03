import SwiftUI

struct LaboratorySampleSubmissionView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State private var showScanner = false
    @State private var selectedSampleType = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
           
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                   
                    LabHeroCard(
                        stepName: "Next Step: Visit Pharmacy",
                        personName: "Mr. Wickrama (Chief Pharmacist)",
                        locationInfo: "2nd Floor, West Wing",
                        currentPosition: "05",
                        waitingTime: "15 mins",
                        gradientColors: [Color.teal, Color.green]
                    )
                    
                    // 3. Lab Technician Info
                    labStaffCard
                    
                    // 4. Sample Tasks List
                    VStack(spacing: 20) {
                        
                        // Blood Sample Card
                        SampleTaskCard(
                            title: "Provide Blood Sample",
                            description: "Requires 8 hours fasting before collection.",
                            icon: "drop.fill",
                            iconColor: .red
                        ) {
                            selectedSampleType = "Blood Sample #BLD-992"
                            showScanner = true
                        }
                        
                        // Urine Sample Card 1
                        SampleTaskCard(
                            title: "Provide Urine Sample",
                            description: "Standard collection container provided at desk.",
                            icon: "flask.fill",
                            iconColor: .blue
                        ) {
                            selectedSampleType = "Urine Sample #URN-112"
                            showScanner = true
                        }
                        
                        // Urine Sample Card 2 (Duplicate from screenshot logic)
                        SampleTaskCard(
                            title: "Provide Stool Sample",
                            description: "Sterile container required. Submit within 2 hours.",
                            icon: "microbe.fill",
                            iconColor: .orange
                        ) {
                            selectedSampleType = "Stool Sample #STL-884"
                            showScanner = true
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
        
        // Navigation to QR View (Reusing MedicationPickupView with generic data)
        .navigationDestination(isPresented: $showScanner) {
            // In a real app, you might create a generic 'QRCodeView',
            // but here we reuse the one we built.
            MedicationPickupView()
                .navigationBarBackButtonHidden(true)
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
            Text("Laboratory Sample Submission")
                .font(.headline)
                .bold()
            Spacer()
            // Placeholder to balance center title
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var labStaffCard: some View {
        VStack(spacing: 0) {
            // Row 1: Technician
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.1)).frame(width: 40, height: 40)
                    Image(systemName: "microscope.fill").foregroundStyle(.blue)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Lab Technician").font(.caption).foregroundStyle(.secondary)
                    Text("Jackson").font(.subheadline).fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(16)
            
            Divider().padding(.leading, 72)
            
            // Row 2: Assigned Doctor
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(Color.gray.opacity(0.1)).frame(width: 40, height: 40)
                    Image(systemName: "cross.case.fill").foregroundStyle(.gray)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Prescription Assigned").font(.caption).foregroundStyle(.secondary)
                    Text("Dr. Sarah Jenkins, PharmD").font(.subheadline).fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 2)
    }
}

// MARK: - Components

// 1. Actionable Sample Card
struct SampleTaskCard: View {
    let title: String
    let description: String
    let icon: String
    let iconColor: Color
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                // Icon Box
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundStyle(iconColor)
                }
                
                // Texts
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            
            // Blue Action Button
            Button(action: action) {
                HStack {
                    Text("Scan at Lab")
                    Image(systemName: "qrcode")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        // Border Stroke
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

// 2. High-Fidelity Hero Card (Reused Logic)
struct LabHeroCard: View {
    let stepName: String
    let personName: String
    let locationInfo: String
    let currentPosition: String
    let waitingTime: String
    let gradientColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(stepName).font(.title3).bold().foregroundStyle(.white)
                    Text(personName).font(.caption).foregroundStyle(.white.opacity(0.9))
                }
                Spacer()
                ZStack {
                    Circle().fill(Color.white.opacity(0.2)).frame(width: 40, height: 40)
                    Image(systemName: "figure.walk").font(.headline).foregroundStyle(.white)
                }
            }
            
            // Location Text
            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse").font(.caption).foregroundStyle(.white.opacity(0.9))
                Text(locationInfo).font(.subheadline).foregroundStyle(.white.opacity(0.9))
            }
            
            // Info Bar
            HStack(spacing: 0) {
                // Position
                HStack(spacing: 12) {
                    ZStack { Circle().fill(Color.teal.opacity(0.1)).frame(width: 44, height: 44); Image(systemName: "person.3.fill").font(.title3).foregroundStyle(.teal) }
                    Text(currentPosition).font(.title2).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
                
                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 40)
                
                // Time
                HStack(spacing: 12) {
                    ZStack { Circle().fill(Color.orange.opacity(0.1)).frame(width: 44, height: 44); Image(systemName: "hourglass").font(.title3).foregroundStyle(.orange) }
                    Text(waitingTime).font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Footer Action
            HStack {
                Text("Please proceed immediately").font(.caption).foregroundStyle(.white.opacity(0.9))
                Spacer()
                Button { } label: {
                    HStack(spacing: 4) { Text("View Map"); Image(systemName: "arrow.right") }
                        .font(.caption).fontWeight(.bold).foregroundStyle(.white)
                }
            }
        }
        .padding(20)
        .background(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: gradientColors.first?.opacity(0.3) ?? .gray, radius: 10, x: 0, y: 5)
    }
}

#Preview {
    LaboratorySampleSubmissionView()
}
