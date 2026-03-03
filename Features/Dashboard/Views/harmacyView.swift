import SwiftUI

struct PharmacyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                   
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search by name or specialty...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(uiColor: .systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    
                    PharmacyHeroCard(
                        stepName: "Next Step: Laboratory",
                        personName: "Ms. Perera (Senior Lab Tech)",
                        locationInfo: "4th Floor, Room 12",
                        currentPosition: "03",
                        waitingTime: "15 mins",
                        status: "Pending",
                        gradientColors: [Color.purple, Color.blue]
                    )
                    
                    
                    pharmacistInfoCard
                    
                  
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Pending
                        medicationSectionHeader(title: "Pending")
                        MedicationRow(
                            name: "Amoxicillin",
                            detail: "500mg • Capsules",
                            statusText: "Filled 2 of 5 times",
                            color: .blue,
                            icon: "chevron.right"
                        )
                        MedicationRow(
                            name: "Lisinopril",
                            detail: "10mg • Tablets",
                            statusText: "Filled 1 of 3 times",
                            color: .blue,
                            icon: "chevron.right"
                        )
                        
                        // Processing
                        medicationSectionHeader(title: "Processing")
                        MedicationRow(
                            name: "Metformin",
                            detail: "850mg • Extended Release",
                            statusText: "Filled 4 of 6 times",
                            color: .orange,
                            icon: "arrow.triangle.2.circlepath" // Spinner icon
                        )
                        
                        // Completed
                        medicationSectionHeader(title: "Completed")
                        MedicationRow(
                            name: "Atorvastatin",
                            detail: "40mg • Tablets",
                            statusText: "Filled 5 of 5 times",
                            color: .green,
                            icon: "checkmark.circle.fill"
                        )
                    }
                    
                    Spacer(minLength: 40)
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
            Text("Pharmacy")
                .font(.headline)
                .bold()
            Spacer()
            // Notification Bell
            Button { } label: {
                Image(systemName: "bell.fill")
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.05), radius: 2)
            }
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var pharmacistInfoCard: some View {
        VStack(spacing: 0) {
            // Row 1: Pharmacist
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.1)).frame(width: 40, height: 40)
                    Image(systemName: "pills.fill").foregroundStyle(.blue)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pharmacist").font(.caption).foregroundStyle(.secondary)
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
    
    private func medicationSectionHeader(title: String) -> some View {
        Text(title)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.top, 8)
    }
}

// MARK: - Components

struct MedicationRow: View {
    let name: String
    let detail: String
    let statusText: String
    let color: Color
    let icon: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Dot Indicator
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(statusText)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(color)
            }
            
            Spacer()
            
            // Right Icon
            Image(systemName: icon)
                .font(icon == "chevron.right" ? .caption : .title3)
                .foregroundStyle(icon == "chevron.right" ? .gray.opacity(0.5) : color)
                .fontWeight(icon == "chevron.right" ? .regular : .bold)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.02), radius: 5, y: 2)
    }
}

// MARK: - Reused Hero Card (Laboratory Style)
struct PharmacyHeroCard: View {
    let stepName: String
    let personName: String
    let locationInfo: String
    let currentPosition: String
    let waitingTime: String
    let status: String
    let gradientColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Top Row
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(stepName)
                        .font(.title3).bold().foregroundStyle(.white)
                    Text(personName)
                        .font(.caption).foregroundStyle(.white.opacity(0.9))
                }
                Spacer()
                ZStack {
                    Circle().fill(Color.white.opacity(0.2)).frame(width: 40, height: 40)
                    Image(systemName: "figure.walk").font(.headline).foregroundStyle(.white)
                }
            }
            
            // Location
            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.caption).foregroundStyle(.white.opacity(0.9))
                Text(locationInfo)
                    .font(.subheadline).foregroundStyle(.white.opacity(0.9))
            }
            
        
            HStack(spacing: 0) {
                // Position
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.purple.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "person.3.fill").font(.title3).foregroundStyle(.purple)
                    }
                    Text(currentPosition)
                        .font(.title2).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
                
                
                Rectangle().fill(Color.gray.opacity(0.2)).frame(width: 1, height: 40)
                
               
                HStack(spacing: 12) {
                    ZStack {
                        Circle().fill(Color.blue.opacity(0.1)).frame(width: 44, height: 44)
                        Image(systemName: "hourglass").font(.title3).foregroundStyle(.blue)
                    }
                    Text(waitingTime)
                        .font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
           
            HStack {
                Text("Please proceed to waiting area")
                    .font(.caption).foregroundStyle(.white.opacity(0.9))
                Spacer()
                Button { } label: {
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
            LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: gradientColors.first?.opacity(0.3) ?? .gray, radius: 10, x: 0, y: 5)
    }
}

#Preview {
    PharmacyView()
}
