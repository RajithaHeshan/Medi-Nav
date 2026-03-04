import SwiftUI

struct PrescriptionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
           
            headerView
            
            // 2. Scrollable Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    patientInfoCard
                    
                    visitDetailsCard
                    
                    medicinesSection
                    
                    attendingDoctorCard
                    
                    // Extra padding at bottom so scroll doesn't hide behind footer
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            
            // 3. Sticky Action Footer
            footerActionsView
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
            Spacer()
            
            Text("Prescription")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
            
            Button {
                // More actions menu
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var patientInfoCard: some View {
        HStack(spacing: 16) {
            // Avatar Placeholder
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundStyle(.orange)
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("xyz abdc")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text("Age 25 | ID: OPD-10293")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
            Spacer()
        }
        .padding(20)
        // Light blue background matching the design
        .background(Color(uiColor: .systemBlue).opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var visitDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("VISIT DETAILS")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .systemBlue))
                .tracking(1.0) // Adds slight letter spacing for HIG small caps style
            
            VStack(spacing: 12) {
                PrescriptionDetailRow(title: "Visit Date", value: "Oct 24, 2023")
                Divider()
                PrescriptionDetailRow(title: "Department", value: "General Medicine")
                Divider()
                PrescriptionDetailRow(title: "Consultation #", value: "REF-8829")
            }
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var medicinesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
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
            
            // Medicine Cards
            VStack(spacing: 12) {
                PrescriptionMedicineCard(
                    medicationName: "Amoxicillin 500mg",
                    badgeText: "Antibiotic",
                    dosage: "1 Tablet",
                    duration: "5 Days",
                    timing: "Morning / Night",
                    instruction: "After meal"
                )
                
                PrescriptionMedicineCard(
                    medicationName: "Paracetamol 500mg",
                    badgeText: "Painkiller",
                    dosage: "2 Tablets",
                    duration: "As required",
                    timing: "When needed",
                    instruction: "Any time"
                )
                
                PrescriptionMedicineCard(
                    medicationName: "Cetirizine 10mg",
                    badgeText: "Antihistamine",
                    dosage: "1 Tablet",
                    duration: "10 Days",
                    timing: "Night Only",
                    instruction: "Before sleep"
                )
            }
        }
    }
    
    private var attendingDoctorCard: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ATTENDING DOCTOR")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .tracking(1.0)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dr. Samantha Perera")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("Internal Medicine")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    
                    Text("SLMC No: 45229")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .tertiaryLabel))
                }
            }
            
            Spacer()
            
            // Digital Signature Stamp
            VStack(spacing: 6) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(uiColor: .systemGray6))
                        .frame(width: 64, height: 64)
                    
                    Image(systemName: "checkmark.seal.fill")
                        .font(.title)
                        .foregroundStyle(Color(uiColor: .systemTeal))
                }
                
                Text("Digitally Signed")
                    .font(.system(size: 10))
                    .foregroundStyle(Color(uiColor: .tertiaryLabel))
            }
        }
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var footerActionsView: some View {
        VStack(spacing: 16) {
            // Share Button
            Button {
                // Share action
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share Prescription")
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(uiColor: .systemBlue))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color(uiColor: .systemBlue).opacity(0.3), radius: 8, x: 0, y: 4)
            }
            
            // Download PDF Button
            Button {
                // Download action
            } label: {
                HStack {
                    Image(systemName: "doc.text")
                    Text("Download PDF")
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8) // Lighter padding since it's secondary
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 24) // Accommodates safe area at the bottom
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        // Shadow to elevate footer above scrolling content
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
    }
}

// MARK: - Reusable Unique Components

struct PrescriptionDetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color(uiColor: .label))
        }
    }
}

struct PrescriptionMedicineCard: View {
    let medicationName: String
    let badgeText: String
    let dosage: String
    let duration: String
    let timing: String
    let instruction: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title & Badge Row
            HStack {
                Text(medicationName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Text(badgeText)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color(uiColor: .systemBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
            
            // 2x2 Grid for Instructions
            VStack(spacing: 12) {
                HStack {
                    MedicineInfoLabel(icon: "pills", text: dosage)
                    Spacer()
                    MedicineInfoLabel(icon: "clock", text: timing)
                }
                HStack {
                    MedicineInfoLabel(icon: "calendar", text: duration)
                    Spacer()
                    MedicineInfoLabel(icon: "fork.knife", text: instruction)
                }
            }
        }
        .padding(16)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
}

struct MedicineInfoLabel: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(Color(uiColor: .systemBlue))
                .frame(width: 16) // Fixes alignment width for icons
            
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
        // Force the frame so the 2x2 grid aligns evenly in the center
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PrescriptionView()
}
