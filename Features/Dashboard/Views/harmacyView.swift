import SwiftUI

struct PharmacyView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var navigateToMap = false
    @State private var navigateToLabSubmission = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        visitPharmacyCard
                        
                        visitLaboratoryCard
                        
                        staffCard
                        
                        medicinesSection
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
        }
        .navigationBarHidden(true)
        
       
        .navigationDestination(isPresented: $navigateToMap) {
            ClinicMapView()
        }
        .navigationDestination(isPresented: $navigateToLabSubmission) {
            LaboratorySampleSubmissionView()
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
            
            Text("Pharmacy")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
    
    private var visitPharmacyCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Visit Pharmacy")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color.blue)
                        .frame(width: 20)
                    Text("Mr. Wickrama (Chief Pharmacist)")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(Color.blue)
                        .frame(width: 20)
                    Text("2nd Floor, West Wing")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill")
                        .foregroundStyle(Color.blue)
                    Text("05")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(height: 24)
                
                HStack(spacing: 8) {
                    Image(systemName: "hourglass")
                        .foregroundStyle(Color.orange)
                    Text("15 mins")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 14)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                
                Button {
                    navigateToMap = true
                } label: {
                    Text("View Map")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.blue)
                }
            }
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
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color.blue)
                        .frame(width: 20)
                    Text("DR. Wickrama")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(Color.blue)
                        .frame(width: 20)
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
                
                Button {
                    navigateToMap = true
                } label: {
                    Text("View Map")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.blue)
                }
            }
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
                PrescriptionMedicineCard(medicationName: "Amoxicillin 500mg", badgeText: "Antibiotic", dosage: "1 Tablet", duration: "5 Days", timing: "Morning / Night", instruction: "After meal")
                PrescriptionMedicineCard(medicationName: "Paracetamol 500mg", badgeText: "Painkiller", dosage: "2 Tablets", duration: "As required", timing: "When needed", instruction: "Any time")
                PrescriptionMedicineCard(medicationName: "Cetirizine 10mg", badgeText: "Antihistamine", dosage: "1 Tablet", duration: "10 Days", timing: "Night Only", instruction: "Before sleep")
            }
        }
    }
}



struct StaffRow: View {
    let imageName: String
    let title: String
    let name: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemGray5))
                    .frame(width: 50, height: 50)
                
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        PharmacyView()
    }
}
