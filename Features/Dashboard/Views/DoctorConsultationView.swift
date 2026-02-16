import SwiftUI
import Combine


struct ConsultationStepItem: Identifiable {
    let id = UUID()
    let stepName: String        // "Next Step: Visit Pharmacy"
    let personName: String      // "Mr. Wickrama (Chief Pharmacist)"
    let locationInfo: String    // "3rd Floor, Room 13"
    let currentPosition: String // "10"
    let waitingTime: String     // "10 mins"
    let status: String          // "In Progress"
    let gradientColors: [Color] // Custom colors for each card
}

struct DoctorConsultationView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Carousel State
    @State private var currentPage = 0
    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    // MARK: - The Data (Pharmacy & Laboratory)
    private let consultationSteps = [
        // Card 1: Pharmacy
        ConsultationStepItem(
            stepName: "Next Step: Pharmacy",
            personName: "Mr. Wickrama (Chief Pharmacist)",
            locationInfo: "3rd Floor, Room 13",
            currentPosition: "10",
            waitingTime: "10 mins",
            status: "In Progress",
            gradientColors: [Color.teal, Color.green]
        ),
        // Card 2: Laboratory
        ConsultationStepItem(
            stepName: "Next Step: Laboratory",
            personName: "Ms. Perera (Senior Lab Tech)",
            locationInfo: "4th Floor, Room 12",
            currentPosition: "10",
            waitingTime: "20 mins",
            status: "In Progress",
            gradientColors: [Color.purple, Color.blue]
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 2. Doctor Info Card (Static)
                        doctorInfoCard
                        
                        // 3. AUTO-SWIPING CAROUSEL (Pharmacy & Lab)
                        TabView(selection: $currentPage) {
                            ForEach(0..<consultationSteps.count, id: \.self) { index in
                                ConsultationStatusCard(step: consultationSteps[index])
                                    .padding(.horizontal, 4) // Tiny padding prevents clipping
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 250) // Adjusted height for the new card layout
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .onAppear {
                            UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
                            UIPageControl.appearance().pageIndicatorTintColor = .systemGray4
                        }
                        .onReceive(timer) { _ in
                            withAnimation(.spring()) {
                                currentPage = (currentPage + 1) % consultationSteps.count
                            }
                        }
                        
                        // 4. Vitals
                        vitalsSection
                        
                        // 5. Prescriptions
                        prescriptionsSection
                        
                        // 6. Lab Reports
                        labReportsSection
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
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
            Text("Doctor Consultation")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var doctorInfoCard: some View {
        HStack(spacing: 16) {
            Image("doctor1") // Ensure asset exists
                .resizable().scaledToFill()
                .frame(width: 50, height: 50).clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Dr. Sarah Jenkins").font(.headline).foregroundStyle(Color(uiColor: .label))
                Text("General Practitioner").font(.caption).foregroundStyle(.secondary)
                Text("Visit Date: Oct 24, 2023").font(.caption2).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.gray.opacity(0.5))
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.2), lineWidth: 1))
    }
    
    private var vitalsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text("Vitals Overview").font(.headline); Spacer(); Button("ALL") { }.font(.caption).bold().foregroundStyle(.blue) }
            HStack(spacing: 12) {
                vitalCard(title: "Blood Pressure", value: "120/80", unit: "mmHg", status: "Normal", color: .green, progress: 0.7)
                vitalCard(title: "Heart Rate", value: "72", unit: "BPM", status: "Normal", color: .green, progress: 0.5)
            }
        }
    }
    
    private func vitalCard(title: String, value: String, unit: String, status: String, color: Color, progress: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Image(systemName: "checkmark.circle.fill").foregroundStyle(color); Spacer(); Text(status).font(.caption2).foregroundStyle(color) }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption).foregroundStyle(.secondary)
                HStack(alignment: .lastTextBaseline, spacing: 2) { Text(value).font(.title3).bold(); Text(unit).font(.caption2).foregroundStyle(.secondary) }
            }
            Capsule().frame(height: 4).foregroundStyle(Color.gray.opacity(0.2))
                .overlay(GeometryReader { geo in Capsule().fill(color).frame(width: geo.size.width * progress) }, alignment: .leading)
        }
        .padding(12).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 12)).shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
    
    private var prescriptionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text("Prescriptions").font(.headline); Spacer(); Button("ALL") { }.font(.caption).bold().foregroundStyle(.blue) }
            VStack(spacing: 12) {
                prescriptionRow(icon: "pills.fill", color: .blue, name: "Amoxicillin 500mg", dosage: "Take 1 tablet twice daily")
                prescriptionRow(icon: "pills.fill", color: .blue, name: "Paracetamol", dosage: "Take 1 tablet twice daily")
            }
            Button { } label: { HStack { Text("Pick up medicine"); Image(systemName: "qrcode") }.font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 12)) }.padding(.top, 8)
        }
    }
    
    private var labReportsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text("Lab Reports").font(.headline); Spacer(); Button("ALL") { }.font(.caption).bold().foregroundStyle(.blue) }
            VStack(spacing: 12) {
                prescriptionRow(icon: "microbe.fill", color: .purple, name: "Urinalysis Report", dosage: "Completed • View PDF")
                prescriptionRow(icon: "drop.fill", color: .red, name: "Complete Blood Count", dosage: "Completed • View PDF")
            }
            Button { } label: { Text("Pick up Report").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding().background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 12)) }.padding(.top, 8)
        }
    }
    
    private func prescriptionRow(icon: String, color: Color, name: String, dosage: String) -> some View {
        HStack(spacing: 16) {
            ZStack { RoundedRectangle(cornerRadius: 10).fill(color.opacity(0.1)).frame(width: 48, height: 48); Image(systemName: icon).font(.title3).foregroundStyle(color) }
            VStack(alignment: .leading, spacing: 4) { Text(name).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label)); Text(dosage).font(.caption).foregroundStyle(.secondary) }
            Spacer()
        }
        .padding(12).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - 4. THE NEW CARD COMPONENT (Matching the provided screenshot)
struct ConsultationStatusCard: View {
    let step: ConsultationStepItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Top Row: Title and Status
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(step.stepName)
                        .font(.title3).bold().foregroundStyle(.white)
                    Text(step.personName)
                        .font(.caption).foregroundStyle(.white.opacity(0.9))
                }
                
                Spacer()
                
                // Status Badge
                Text(step.status)
                    .font(.caption).fontWeight(.bold)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            // Location Row
            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.9))
                Text(step.locationInfo)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
            }
            
            // Prominent White Info Card
            HStack(spacing: 0) {
                // Current Position
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.teal.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "person.3.fill").font(.title3).foregroundStyle(.teal)
                    }
                    Text(step.currentPosition)
                        .font(.title2).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
                
                // Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 1, height: 40)
                
                // Estimated Waiting Time
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.orange.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "hourglass").font(.title3).foregroundStyle(.orange)
                    }
                    Text(step.waitingTime)
                        .font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Bottom Row: Action
            HStack {
                Text("Please proceed to waiting area")
                    .font(.caption).foregroundStyle(.white.opacity(0.9))
                
                Spacer()
                
                Button {
                    // Action for Map
                } label: {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption).fontWeight(.bold).foregroundStyle(.white)
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(colors: step.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: step.gradientColors.first?.opacity(0.3) ?? .gray, radius: 10, x: 0, y: 5)
    }
}

#Preview {
    DoctorConsultationView()
}
