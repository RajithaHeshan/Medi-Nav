
import SwiftUI

struct PrescriptionDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    // Data passed in
    var medicineName: String = "Lisinopril 10mg"
    var dosage: String = "Twice a day • Before breakfast"
    var status: String = "Needs Refill"
    var statusColor: Color = .red
    
    // Specific Details
    var assignDate: String = "Oct 24, 2023"
    var dateRange: String = "Oct 24, 2023 - Nov 24, 2023"
    var doctorName: String = "Dr. Sarah Jenkins"
    var pharmacistName: String = "Mr. Wickrama (Chief)"
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // 2. Hero Card (Medicine Info)
                    heroMedicineCard
                    
                    // 3. Timeline / Dates
                    detailSection(title: "Timeline") {
                        VStack(spacing: 16) {
                            DetailRow(icon: "calendar.badge.clock", title: "Assigned Date", value: assignDate)
                            Divider()
                            DetailRow(icon: "calendar", title: "Usage Period", value: dateRange)
                        }
                    }
                    
                    // 4. Authorized Personnel
                    detailSection(title: "Authorized By") {
                        VStack(spacing: 16) {
                            DetailRow(icon: "stethoscope", title: "Prescribing Doctor", value: doctorName)
                            Divider()
                            DetailRow(icon: "cross.case.fill", title: "Pharmacist", value: pharmacistName)
                        }
                    }
                    
                    // 5. Instruction Note
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.headline)
                        Text("Take one tablet in the morning and one in the evening before meals. Do not crush or chew. Keep hydrated.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineSpacing(4)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1)))
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
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundStyle(.blue)
            }
            Spacer()
            Text("Prescription Details").font(.headline).bold()
            Spacer()
            // Balance text
            Text("Back").opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var heroMedicineCard: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(statusColor.opacity(0.1))
                    .frame(width: 60, height: 60)
                Image(systemName: "pills.fill")
                    .font(.title2)
                    .foregroundStyle(statusColor)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(medicineName)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(dosage)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(status)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor)
                    .clipShape(Capsule())
                    .padding(.top, 4)
            }
            Spacer()
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5)
    }
    
    private func detailSection<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            VStack {
                content()
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.05)))
        }
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(Color.blue.opacity(0.05)).frame(width: 36, height: 36)
                Image(systemName: icon).font(.caption).foregroundStyle(.blue)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption).foregroundStyle(.secondary)
                Text(value).font(.subheadline).fontWeight(.medium).foregroundStyle(Color(uiColor: .label))
            }
            Spacer()
        }
    }
}

#Preview {
    PrescriptionDetailView()
}
