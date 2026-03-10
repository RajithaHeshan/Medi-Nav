import SwiftUI

struct MedicalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
  
    @State private var showLabHistory = false
  
    @State private var showPrescriptionHistory = false
    @State private var showVitalHistory = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // Search
                        searchBar
                        
                        // List Group
                        VStack(spacing: 1) {
                            
                            // Lab Reports
                            HistoryMenuRow(
                                title: "Lab Report History",
                                subtitle: "24 total reports",
                                iconName: "flask.fill",
                                iconColor: .cyan,
                                bgColor: .cyan.opacity(0.1)
                            ) {
                                showLabHistory = true
                            }
                            
                            // 🔴 2. TRIGGER NAVIGATION HERE
                            HistoryMenuRow(
                                title: "Prescription History",
                                subtitle: "Last filled: Oct 12, 2025",
                                iconName: "pills.fill",
                                iconColor: .green,
                                bgColor: .green.opacity(0.1)
                            ) {
                                showPrescriptionHistory = true
                            }
                            
                            // Vital Signs
                            HistoryMenuRow(
                                title: "Vital Signs History",
                                subtitle: "Last filled: Oct 12, 2025",
                                iconName: "heart.fill",
                                iconColor: .red,
                                bgColor: .red.opacity(0.1)
                            ) {
                                showVitalHistory = true
                            }
                        }
                        .background(Color.clear)
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // MARK: - Navigation Destinations
            
            // 🔴 3. DESTINATION: MyPrescriptionView
            .navigationDestination(isPresented: $showPrescriptionHistory) {
//                MyPrescriptionView()
//                    .navigationBarBackButtonHidden(true)
            }
            
            // Other destinations...
            .navigationDestination(isPresented: $showLabHistory) {
                LaboratorySampleSubmissionView() // Placeholder
                    .navigationBarBackButtonHidden(true)
            }
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
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            Text("Medical History").font(.headline).bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding().background(Color(uiColor: .systemBackground))
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.gray)
            TextField("Search by name or specialty...", text: $searchText)
        }
        .padding(12).background(Color(uiColor: .secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Polished Row Component
struct HistoryMenuRow: View {
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: Color
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(bgColor).frame(width: 48, height: 48)
                    Image(systemName: iconName).font(.headline).foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label))
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Vector Icon (Chevron)
                Image(systemName: "chevron.right")
                    .font(.caption).fontWeight(.bold).foregroundStyle(.gray.opacity(0.4))
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MedicalHistoryView()
}
