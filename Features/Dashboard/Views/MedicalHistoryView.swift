import SwiftUI

struct MedicalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    // MARK: - Navigation States
    @State private var showLabHistory = false
    @State private var showPrescriptionHistory = false
    @State private var showVitalHistory = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // 1. Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        // 2. Search Bar
                        searchBar
                        
                        // 3. Lab Report History Card
                        HistoryMenuCard(
                            title: "Lab Report History",
                            subtitle: "24 total reports",
                            iconName: "flask.fill", // SF Symbol for Beaker
                            iconColor: .cyan,
                            bgColor: .cyan.opacity(0.1)
                        ) {
                            showLabHistory = true
                        }
                        
                        // 4. Prescription History Card
                        HistoryMenuCard(
                            title: "Prescription History",
                            subtitle: "Last filled: oct 12, 2025",
                            iconName: "pills.fill", // SF Symbol for Meds
                            iconColor: .green,
                            bgColor: .green.opacity(0.1)
                        ) {
                            // This navigates to the Prescription View we made earlier
                            showPrescriptionHistory = true
                        }
                        
                        // 5. Vital Signs History Card
                        HistoryMenuCard(
                            title: "Vital Signs History",
                            subtitle: "Last filled: oct 12, 2025",
                            iconName: "heart.fill", // SF Symbol for Heart
                            iconColor: .red,
                            bgColor: .red.opacity(0.1)
                        ) {
                            // This navigates to the Vital View we made earlier
                            showVitalHistory = true
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground)) // Clean light gray background
            .navigationBarHidden(true)
            
            // MARK: - Navigation Destinations
            
            // 1. Lab History (Placeholder or Link to Lab View)
            .navigationDestination(isPresented: $showLabHistory) {
                // Linking to the Sample Submission view as a placeholder,
                // or you can create a new LabResultListView
                LaboratorySampleSubmissionView()
                    .navigationBarBackButtonHidden(true)
            }
            
            // 2. Prescription History (Links to MyPrescriptionView)
            .navigationDestination(isPresented: $showPrescriptionHistory) {
                MyPrescriptionView()
                    .navigationBarBackButtonHidden(true)
            }
            
            // 3. Vital History (Links to VitalView)
            .navigationDestination(isPresented: $showVitalHistory) {
                VitalView()
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
            Text("Medical History")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            TextField("Search by name or specialty...", text: $searchText)
        }
        .padding(14)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Reusable History Menu Card
struct HistoryMenuCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: Color
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                
                // Big Icon Circle
                ZStack {
                    Circle()
                        .fill(bgColor) // Light pastel background
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: iconName)
                        .font(.title2)
                        .foregroundStyle(iconColor)
                }
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.05), lineWidth: 1)
                )
                
                // Text Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.body)
                    .foregroundStyle(.gray.opacity(0.4))
            }
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            // Soft Shadow
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle()) // Standard tap behavior
    }
}

#Preview {
    MedicalHistoryView()
}
