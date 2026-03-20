
import SwiftUI

struct LabSampleSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var navigateToPharmacy = false
    @State private var navigateToMap = false
    @State private var navigateToLabReports = false
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        statusCompletedCard
                        
                        personnelCard
                        
                        nextStepPharmacyCard
                        
                        
                        Button {
                            navigateToLabReports = true
                        } label: {
                            Text("View Lab Report")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToPharmacy) {
            PharmacyView()
        }
        .navigationDestination(isPresented: $navigateToMap) {
           
            Text("Clinic Map View Placeholder")
        }
        .navigationDestination(isPresented: $navigateToLabReports) {
         
            LabReportsView()
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
            Text("Submission Complete")
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
                Text("Sample Submitted")
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
    
    private var personnelCard: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image("images (2)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .background(Circle().fill(Color(uiColor: .systemGray5)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lab Technician")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("Jackson")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                Spacer()
            }
            
            Divider()
            
            HStack(spacing: 16) {
                Image("Image (2)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .background(Circle().fill(Color(uiColor: .systemGray5)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Prescription Assigned")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("Dr. Sarah Jenkins, PharmD")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                Spacer()
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var nextStepPharmacyCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Step: Visit Pharmacy")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill").foregroundStyle(Color.blue).frame(width: 20)
                    Text("DR. Wickrama").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            Button {
                navigateToPharmacy = true
            } label: {
                Text("Check in to Pharmacy")
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
}

#Preview {
    NavigationStack {
        LabSampleSuccessView()
    }
}
