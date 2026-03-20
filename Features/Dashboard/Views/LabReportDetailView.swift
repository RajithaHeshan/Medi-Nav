import SwiftUI

struct LabReportDetailView: View {
    @Environment(\.dismiss) var dismiss
    
   
    let reportTitle: String
    let status: LabStatus 
    
    var body: some View {
        VStack(spacing: 0) {
       
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
               
                    statusBanner
                    
                    // Info Section
                    infoSection
                    
                    // Dynamic Results
                    if reportTitle.contains("Blood") {
                        bloodTestResults
                    } else {
                        urineTestResults
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Download Button
                    Button { } label: {
                        HStack {
                            Text("Download PDF")
                            Image(systemName: "arrow.down.doc.fill")
                        }
                        .font(.headline).fontWeight(.bold).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .blue.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
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
            Text(reportTitle).font(.headline).bold()
            Spacer()
            Text("Back").opacity(0)
        }
        .padding().background(Color(uiColor: .systemBackground))
    }
    
    private var statusBanner: some View {
        HStack {
            Image(systemName: status == .ready ? "checkmark.circle.fill" : "clock.fill")
                .foregroundStyle(status.textColor)
            Text(status.title)
                .font(.headline)
                .foregroundStyle(status.textColor)
            Spacer()
            Text("Oct 24, 2023").font(.caption).foregroundStyle(.secondary)
        }
        .padding()
        .background(status.bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(status.textColor.opacity(0.2), lineWidth: 1))
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Report Details").font(.headline)
            VStack(spacing: 0) {
                detailRow(title: "Patient", value: "Rajitha Heshan", icon: "person.fill")
                Divider().padding(.leading, 44)
                detailRow(title: "Ordered By", value: "Dr. Sarah Johnson", icon: "stethoscope")
                Divider().padding(.leading, 44)
                detailRow(title: "Lab ID", value: "#LAB-99283", icon: "barcode")
            }
            .background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var bloodTestResults: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Test Results").font(.headline)
            VStack(spacing: 0) {
                resultRow(name: "Glucose (Fasting)", value: "92 mg/dL", range: "70-99", status: .normal)
                Divider()
                resultRow(name: "HbA1c", value: "5.4%", range: "< 5.7%", status: .normal)
                Divider()
                resultRow(name: "Cholesterol", value: "210 mg/dL", range: "< 200", status: .high)
            }
            .background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var urineTestResults: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Test Results").font(.headline)
            VStack(spacing: 0) {
                resultRow(name: "Color", value: "Pale Yellow", range: "Yellow", status: .normal)
                Divider()
                resultRow(name: "pH Level", value: "6.0", range: "4.5-8.0", status: .normal)
                Divider()
                resultRow(name: "Protein", value: "Negative", range: "Negative", status: .normal)
            }
            .background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func detailRow(title: String, value: String, icon: String) -> some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(Color.blue.opacity(0.1)).frame(width: 32, height: 32)
                Image(systemName: icon).font(.caption).foregroundStyle(.blue)
            }
            Text(title).font(.subheadline).foregroundStyle(.secondary)
            Spacer()
            Text(value).font(.subheadline).fontWeight(.medium)
        }
        .padding()
    }
    
   
    enum ResultStatus { case normal, high, low }
    
    private func resultRow(name: String, value: String, range: String, status: ResultStatus) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(.subheadline).fontWeight(.medium)
                Text("Ref: \(range)").font(.caption2).foregroundStyle(.secondary)
            }
            Spacer()
          
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(status == .normal ? Color.primary : Color.red)
        }
        .padding()
    }
}

#Preview {
    LabReportDetailView(
        reportTitle: "Blood Glucose",
        status: .ready
    )
}
