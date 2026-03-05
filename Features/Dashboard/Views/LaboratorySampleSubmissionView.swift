
import SwiftUI

struct LaboratorySampleSubmissionView: View {
    @Environment(\.dismiss) var dismiss
    
    // 🔴 NEW: Navigation States
    @State private var navigateToPharmacy = false
    @State private var navigateToLabSamplePickup = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Navigation Header
            headerView
            
            // 2. Scrollable Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    visitLaboratoryCard
                    
                    nextStepPharmacyCard
                    
                    personnelCard
                    
                    bloodSampleCard
                    
                    urineSampleCard
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
        .navigationBarHidden(true)
        
        // 🔴 NEW: Navigation to Pharmacy View
        .navigationDestination(isPresented: $navigateToPharmacy) {
            PharmacyView()
        }
        
        // 🔴 NEW: Navigation to Lab Sample Pickup View (QR Code)
        .navigationDestination(isPresented: $navigateToLabSamplePickup) {
            LabSamplePickupView()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
            Spacer()
            
            Text("Laboratory Sample Submission")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
            
            // Invisible placeholder to keep the title centered
            Image(systemName: "chevron.left")
                .font(.title2)
                .opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var visitLaboratoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header Row
            HStack {
                Text("Visit Laboratory")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                // Time Badge
                Text("10:30 AM")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(uiColor: .systemBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
            
            // Location Info
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .frame(width: 20)
                    Text("DR. Wickrama")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .frame(width: 20)
                    Text("2nd Floor, West Wing")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            // Queue Status Box
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill")
                        .font(.title3)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                    Text("5 Queue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Image(systemName: "hourglass")
                        .font(.title3)
                        .foregroundStyle(.brown)
                    Text("15 mins")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Footer
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button {
                    // View Map Action
                } label: {
                    Text("View Map")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                }
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
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            // Location Info
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .frame(width: 20)
                    Text("DR. Wickrama")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                HStack(spacing: 12) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(Color(uiColor: .systemBlue))
                        .frame(width: 20)
                    Text("2nd Floor, West Wing")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            // 🔴 UPDATED: Fixed Button Alignment, Sizing, and Navigation
            Button {
                navigateToPharmacy = true
            } label: {
                HStack(spacing: 8) {
                    Text("Check In to Pharmacy")
                        .fontWeight(.semibold)
                    Image(systemName: "qrcode.viewfinder")
                }
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color(uiColor: .systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Footer
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button {
                    // View Map Action
                } label: {
                    Text("View Map")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var personnelCard: some View {
        VStack(spacing: 16) {
            // Lab Technician
            HStack(spacing: 16) {
                // 🔴 UPDATED: Added your requested asset image for Lab Technician
                Image("images (2)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .background(Circle().fill(Color(uiColor: .systemGray5)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lab Technician")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("Jackson")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                Spacer()
            }
            
            Divider()
            
            // Pharmacist / Doctor
            HStack(spacing: 16) {
                // 🔴 UPDATED: Added your requested asset image for Doctor
                Image("Image (2)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .background(Circle().fill(Color(uiColor: .systemGray5)))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Prescription Assigned")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("Dr. Sarah Jenkins, PharmD")
                        .font(.headline)
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
    
    private var bloodSampleCard: some View {
        SampleTaskCard(
            title: "Provide Blood Sample",
            description: "Requires 8 hours fasting before collection.",
            icon: "drop.fill",
            iconColor: Color(uiColor: .systemRed),
            iconBackground: Color(uiColor: .systemRed).opacity(0.1),
            buttonAction: {
                // 🔴 UPDATED: Navigates to the QR code view
                navigateToLabSamplePickup = true
            }
        )
    }
    
    private var urineSampleCard: some View {
        SampleTaskCard(
            title: "Provide Urine Sample",
            description: "Standard collection container provided at desk.",
            icon: "flask.fill",
            iconColor: .orange,
            iconBackground: Color.orange.opacity(0.1),
            buttonAction: {
                // 🔴 UPDATED: Navigates to the QR code view
                navigateToLabSamplePickup = true
            }
        )
    }
}

// MARK: - Reusable View Components

struct SampleTaskCard: View {
    let title: String
    let description: String
    let icon: String
    let iconColor: Color
    let iconBackground: Color
    let buttonAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                // Icon Box
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconBackground)
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .lineSpacing(2)
                }
                Spacer()
            }
            
            // Scan Button
            Button(action: buttonAction) {
                HStack(spacing: 8) {
                    Text("Scan at Lab")
                        .fontWeight(.bold)
                    Image(systemName: "qrcode.viewfinder")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(uiColor: .systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 12))
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
        LaboratorySampleSubmissionView()
    }
}
