import SwiftUI

struct PrescriptionCompleteView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var navigateToLabSubmission = false
    @State private var navigateToMap = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        statusCompletedCard
                        
                        staffCard
                        
                        
                        visitLaboratoryCard
                        
                        medicinesSection
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToLabSubmission) {
            LaboratorySampleSubmissionView()
        }
        .navigationDestination(isPresented: $navigateToMap) {
            ClinicMapView()
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
            Text("Order Summary")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
    
    private var statusCompletedCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(Color.green.opacity(0.15)).frame(width: 50, height: 50)
                Image(systemName: "checkmark.circle.fill").font(.title2).foregroundStyle(.green)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Prescription Ready")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("Status: Completed")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
            }
            Spacer()
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var staffCard: some View {
        VStack(spacing: 16) {
           
            StaffRow(imageName: "doctor1", title: "Pharmacist", name: "DR. Ishan")
            Divider()
            StaffRow(imageName: "doctor2", title: "Prescription Assistant", name: "DR. Pranendo")
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var visitLaboratoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Step: Visit Laboratory")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill").foregroundStyle(Color.blue).frame(width: 20)
                    Text("DR. Wickrama")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).frame(width: 20)
                    Text("2nd Floor, West Wing")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            Button {
                navigateToLabSubmission = true
            } label: {
                Text("Check in to Laboratory")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button { navigateToMap = true } label: {
                    Text("View Map").font(.subheadline).fontWeight(.bold).foregroundStyle(Color.blue)
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var medicinesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Medicines & Dosage")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Spacer()
                Text("3 ITEMS")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(uiColor: .systemBlue))
                    .clipShape(Capsule())
            }
            
            VStack(spacing: 12) {
               
                CompletedMedicineCard(medicationName: "Amoxicillin 500mg", dosage: "1 Tablet", duration: "5 Days", timing: "Morning / Night", instruction: "After meal")
                CompletedMedicineCard(medicationName: "Paracetamol 500mg", dosage: "2 Tablets", duration: "As required", timing: "When needed", instruction: "Any time")
                CompletedMedicineCard(medicationName: "Cetirizine 10mg", dosage: "1 Tablet", duration: "10 Days", timing: "Night Only", instruction: "Before sleep")
            }
        }
    }
}


fileprivate struct CompletedMedicineCard: View {
    let medicationName: String
    let dosage: String
    let duration: String
    let timing: String
    let instruction: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(medicationName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
              
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.caption2)
                    Text("Completed")
                        .font(.caption2)
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color.green)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.green.opacity(0.15))
                .clipShape(Capsule())
            }
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "pills")
                            .foregroundStyle(Color.blue)
                            .frame(width: 16)
                        Text(dosage)
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.blue)
                            .frame(width: 16)
                        Text(duration)
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.blue)
                            .frame(width: 16)
                        Text(timing)
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(Color.blue)
                            .frame(width: 16)
                        Text(instruction)
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.green.opacity(0.3), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        PrescriptionCompleteView()
    }
}
