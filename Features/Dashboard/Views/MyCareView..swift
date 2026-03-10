import SwiftUI

struct MyCareView: View {
    @Environment(\.dismiss) var dismiss
    
   
    @State private var navigateToPharmacy = false
    @State private var navigateToLabReports = false
    @State private var navigateToMedicalHistory = false
    @State private var navigateToVitalReports = false
    @State private var navigateToLabSubmission = false
    @State private var navigateToPrescriptionHistory = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
              
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        
                
                        actionGridSection
                        
                   
                        orderRoutineSection
                        
               
                        medicationsSection
                        
                        
                        recentActivitySection
                        
                     
                        bodyMetricsSection
                        
                 
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
            }
        }
        .navigationBarHidden(true)
        
        
        .navigationDestination(isPresented: $navigateToPharmacy) {
            PharmacyView()
        }
        .navigationDestination(isPresented: $navigateToLabReports) {
            LabReportsView()
        }
        .navigationDestination(isPresented: $navigateToMedicalHistory) {
            MedicalHistoryView()
        }
        .navigationDestination(isPresented: $navigateToVitalReports) {
            VitalView()
        }
        .navigationDestination(isPresented: $navigateToLabSubmission) {
            LaboratorySampleSubmissionView()
        }
        .navigationDestination(isPresented: $navigateToPrescriptionHistory) {
            
            MyPrescriptionView()
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
            
            Text("My Care")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
    
    private var actionGridSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            Button { navigateToPharmacy = true } label: {
                MyCareActionCard(title: "Pharmacy", iconName: "pills.fill", iconColor: Color(uiColor: .systemPink))
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToLabReports = true } label: {
                MyCareActionCard(title: "Lab Reports", iconName: "clipboard.fill", iconColor: Color(uiColor: .systemOrange))
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToMedicalHistory = true } label: {
                MyCareActionCard(title: "Medical History", iconName: "doc.text.fill", iconColor: Color(uiColor: .systemBlue))
            }
            .buttonStyle(PlainButtonStyle())
            
            Button { navigateToVitalReports = true } label: {
                MyCareActionCard(title: "Vital Reports", iconName: "heart.text.square.fill", iconColor: Color(uiColor: .systemPurple))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var orderRoutineSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Order Routine Testing")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            HStack {
                Button { navigateToLabSubmission = true } label: {
                    RoutingTestIcon(title: "Blood Test", icon: "drop.fill", color: Color(uiColor: .systemRed))
                }
                
                Spacer()
                
                Button { navigateToLabSubmission = true } label: {
                    RoutingTestIcon(title: "Urine Test", icon: "flask.fill", color: Color(uiColor: .systemYellow))
                }
                
                Spacer()
                
                Button { navigateToLabSubmission = true } label: {
                    RoutingTestIcon(title: "General Health", icon: "stethoscope", color: Color(uiColor: .systemBlue))
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var medicationsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Medications")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(spacing: 12) {
                MyCareMedicationRow(
                    title: "Amoxicillin 500mg",
                    timeText: "08:00 AM (Due)",
                    icon: "cross.vial.fill",
                    iconColor: Color(uiColor: .systemBlue),
                    isTaken: false
                )
                
                MyCareMedicationRow(
                    title: "Vitamin D",
                    timeText: "Taken at 7:00 AM",
                    icon: "sun.max.fill",
                    iconColor: Color(uiColor: .systemGreen),
                    isTaken: true
                )
            }
        }
    }
    
    private var recentActivitySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Activity")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(spacing: 0) {
                Button { navigateToVitalReports = true } label: {
                    RecentActivityListItem(icon: "checkmark", iconBg: .systemGreen, title: "General Checkup", subtitle: "Completed Oct 12 • Dr. Smith")
                }
                
                Divider().padding(.leading, 56)
                
                Button { navigateToLabReports = true } label: {
                    RecentActivityListItem(icon: "testtube.2", iconBg: .systemBlue, title: "Blood Test Results", subtitle: "Available Oct 08 • Lab Corp")
                }
                
                Divider().padding(.leading, 56)
                
                Button { navigateToPrescriptionHistory = true } label: {
                    RecentActivityListItem(icon: "pills.fill", iconBg: .systemOrange, title: "Prescription Refill", subtitle: "Processed Oct 05 • CVS Pharmacy")
                }
            }
            .buttonStyle(PlainButtonStyle())
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
        }
    }
    
    private var bodyMetricsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Body Metrics")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text("Healthy")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemGreen))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(uiColor: .systemGreen).opacity(0.1))
                    .clipShape(Capsule())
            }
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("22.4")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("BMI")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("Underweight").font(.caption2).foregroundStyle(.secondary)
                    Spacer()
                    Text("Obese").font(.caption2).foregroundStyle(.secondary)
                }
                
                HStack(spacing: 0) {
                    Rectangle().fill(Color(uiColor: .systemBlue).opacity(0.5)).frame(maxWidth: .infinity)
                    Rectangle().fill(Color(uiColor: .systemGreen)).frame(maxWidth: .infinity)
                    Rectangle().fill(Color(uiColor: .systemYellow)).frame(maxWidth: .infinity)
                    Rectangle().fill(Color(uiColor: .systemRed).opacity(0.7)).frame(maxWidth: .infinity)
                }
                .frame(height: 8)
                .clipShape(Capsule())
            }
            .padding(.vertical, 8)
            
            Text("Your BMI is in the healthy range. Maintain your current diet and activity levels.")
                .font(.caption)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Reusable Components

struct MyCareActionCard: View {
    let title: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 56, height: 56)
                
                Image(systemName: iconName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(iconColor)
            }
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

struct RoutingTestIcon: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 64, height: 64)
                
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
            }
            
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}

struct MyCareMedicationRow: View {
    let title: String
    let timeText: String
    let icon: String
    let iconColor: Color
    let isTaken: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(iconColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                HStack(spacing: 4) {
                    if !isTaken { Image(systemName: "clock") }
                    Text(timeText)
                }
                .font(.caption)
                .fontWeight(isTaken ? .regular : .semibold)
                .foregroundStyle(isTaken ? Color(uiColor: .secondaryLabel) : Color(uiColor: .systemOrange))
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(isTaken ? Color.clear : Color(uiColor: .systemGray3), lineWidth: 2)
                    .frame(width: 28, height: 28)
                
                if isTaken {
                    Circle()
                        .fill(Color(uiColor: .systemGreen))
                        .frame(width: 28, height: 28)
                    Image(systemName: "checkmark")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
        .opacity(isTaken ? 0.7 : 1.0)
    }
}

struct RecentActivityListItem: View {
    let icon: String
    let iconBg: UIColor
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(uiColor: iconBg).opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundStyle(Color(uiColor: iconBg))
                    .font(.subheadline.bold())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color(uiColor: .systemGray3))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        MyCareView()
    }
}
