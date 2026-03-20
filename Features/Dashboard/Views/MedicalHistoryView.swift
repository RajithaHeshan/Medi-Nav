import SwiftUI

struct MedicalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    

    @State private var showLabHistory = false
    @State private var showPrescriptionHistory = false
    @State private var showVitalHistory = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
         
                headerView
                
           
                searchBar
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 16) {
                        
                    
                        HistoryMenuRow(
                            title: "Lab Report History",
                            subtitle: "24 total reports",
                            iconName: "flask.fill",
                            iconColor: .cyan,
                            bgColor: .cyan.opacity(0.15)
                        ) {
                            showLabHistory = true
                        }
                        
                      
                        HistoryMenuRow(
                            title: "Prescription History",
                            subtitle: "Last filled: Oct 12, 2025",
                            iconName: "pills.fill",
                            iconColor: .green,
                            bgColor: .green.opacity(0.15)
                        ) {
                            showPrescriptionHistory = true
                        }
                        
                    
                        HistoryMenuRow(
                            title: "Vital Signs History",
                            subtitle: "Last filled: Oct 12, 2025",
                            iconName: "heart.fill",
                            iconColor: .red,
                            bgColor: .red.opacity(0.15)
                        ) {
                            showVitalHistory = true
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
        }
        .navigationBarHidden(true)
        
   
        .navigationDestination(isPresented: $showLabHistory) {
            LabReportHistoryView()
        }
        .navigationDestination(isPresented: $showPrescriptionHistory) {
            MyPrescriptionView()
        }
        .navigationDestination(isPresented: $showVitalHistory) {
            VitalHistoryView()
        }
    }
    
   
    private var headerView: some View {
        HStack(spacing: 16) {
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
            
            Text("Medical History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
  
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
            
            TextField("Search history...", text: $searchText)
            
            Spacer()
            
            if !searchText.isEmpty {
                Button(action: {
                    withAnimation { searchText = "" }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .font(.body.weight(.medium))
                }
            } else {
                Image(systemName: "mic.fill")
                    .foregroundStyle(Color(uiColor: .systemGray2))
                    .font(.body.weight(.medium))
            }
        }
        .padding(10)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}


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
                    Circle()
                        .fill(bgColor)
                        .frame(width: 56, height: 56)
                    Image(systemName: iconName)
                        .font(.title3)
                        .foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
              
                Image(systemName: "chevron.right")
                    .font(.subheadline.bold())
                    .foregroundStyle(Color(uiColor: .systemGray3))
            }
            .padding(20)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.1), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct LabReportHistoryView1: View {
    var body: some View {
        Text("Lab Report History Screen").font(.title)
    }
}

struct VitalHistoryView1: View {
    var body: some View {
        Text("Vital History Screen").font(.title)
    }
}

#Preview {
    NavigationStack {
        MedicalHistoryView()
    }
}

