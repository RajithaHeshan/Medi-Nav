
import SwiftUI

struct ConsultationDetailView: View {
    @Environment(\.dismiss) var dismiss
    
  
    let doctorName: String
    let specialty: String
    let date: String
    let image: String
    
    var body: some View {
        VStack(spacing: 0) {
            
          
            customHeaderView
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                   
                    statusSummaryRow
                    
                 
                    clinicalNotesSection
                    
                 
                    vitalsSection
                    
                 
                    prescriptionsSection
                    
               
                    labReportsSection
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemBackground))
        .navigationBarHidden(true)
    }
    

    
   
    private var customHeaderView: some View {
        HStack(alignment: .center) {
         
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .frame(width: 44, alignment: .leading)
            
            Spacer()
            
        
            HStack(spacing: 12) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(doctorName)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    HStack(spacing: 4) {
                        Text(specialty)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundStyle(.yellow)
                        
                        Text("4.9") // Hardcoded rating as per design
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            
            Spacer()
            
            // Info Button
            Button {
                // Info Action
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.blue)
            }
            .frame(width: 44, alignment: .trailing)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color(uiColor: .systemBackground))
    }
    
    private var statusSummaryRow: some View {
        HStack {
            Text(date)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text("COMPLETED")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.gray)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color(uiColor: .systemGray6))
                .clipShape(Capsule())
        }
        .padding(.top, 8)
    }
    
    private var clinicalNotesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Doctor's Clinical Notes")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            Text("Patient presented with a mild cough and congestion for 3 days. Lung sounds clear. Blood pressure stable compared to last visit. Prescribed amoxicillin for suspected sinus infection. Advised rest and increased fluid intake. Follow-up in 2 weeks if symptoms persist.")
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .label))
                .lineSpacing(4)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var vitalsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vitals Recorded")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 12) {
                vitalDetailCard(title: "Blood Pressure", value: "120/80", unit: "mmHg", progress: 0.7)
                vitalDetailCard(title: "Heart Rate", value: "72", unit: "BPM", progress: 0.5)
            }
        }
    }
    
    private func vitalDetailCard(title: String, value: String, unit: String, progress: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                Spacer()
                Text("Normal").font(.caption2).foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption).foregroundStyle(.secondary)
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text(value).font(.title3).bold()
                    Text(unit).font(.caption2).foregroundStyle(.secondary)
                }
            }
            Capsule().frame(height: 4).foregroundStyle(Color.gray.opacity(0.1))
                .overlay(GeometryReader { geo in Capsule().fill(Color.green).frame(width: geo.size.width * progress) }, alignment: .leading)
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var prescriptionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text("Prescriptions").font(.headline); Spacer(); Button("ALL") {}.font(.caption).fontWeight(.bold).foregroundStyle(.blue) }
            VStack(spacing: 12) {
                detailRow(icon: "pills.fill", color: .blue, title: "Amoxicillin 500mg", subtitle: "Take 1 tablet twice daily")
                detailRow(icon: "cross.case.fill", color: .blue, title: "Paracetamol", subtitle: "Take 1 tablet twice daily")
            }
        }
    }
    
    private var labReportsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text("Lab Reports").font(.headline); Spacer(); Button("ALL") {}.font(.caption).fontWeight(.bold).foregroundStyle(.blue) }
            VStack(spacing: 12) {
                detailRow(icon: "microbe.fill", color: .purple, title: "Urinalysis Report", subtitle: "Completed • View PDF")
                detailRow(icon: "drop.fill", color: .red, title: "Complete Blood Count", subtitle: "Completed • View PDF")
            }
        }
    }
    
    private func detailRow(icon: String, color: Color, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(color.opacity(0.1)).frame(width: 44, height: 44)
                Image(systemName: icon).font(.body).foregroundStyle(color)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label))
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(8).background(Color.clear)
    }
}

#Preview {
    ConsultationDetailView(
        doctorName: "Dr. Sarah Jenkins",
        specialty: "Internal Medicine",
        date: "Oct 24, 2023",
        image: "doctor1"
    )
}
