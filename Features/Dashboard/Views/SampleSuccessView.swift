import SwiftUI

struct SampleSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
     
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                
                    successIconView
                        .padding(.top, 20)
                    
                 
                    VStack(spacing: 16) {
                        Text("Report sample submitted successfully")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(uiColor: .label))
                            .multilineTextAlignment(.center)
                        
                        Text("Your prescription has been sent to MediCare Pharmacy. You will receive a notification when it is ready for pickup.")
                            .font(.body)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .lineSpacing(4)
                    }
                    
                    // 4. Details Card
                    detailsCardView
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .background(Color(uiColor: .systemBackground))
        .navigationBarHidden(true)
    }
    
  
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            Spacer()
        }
        .padding()
    }
    
    private var successIconView: some View {
        ZStack {
            Circle()
                .fill(Color(uiColor: .systemGreen).opacity(0.1))
                .frame(width: 120, height: 120)
            
            Image(systemName: "checkmark")
                .font(.system(size: 50, weight: .medium))
                .foregroundStyle(Color(uiColor: .systemGreen))
        }
    }
    
    private var detailsCardView: some View {
        VStack(spacing: 0) {
            SuccessDetailRow(
                icon: "doc.text.fill",
                title: "Order ID",
                value: "#PF-94021",
                valueColor: Color(uiColor: .label)
            )
            
            Divider().padding(.leading, 64)
            
            SuccessDetailRow(
                icon: "cross.case.fill",
                title: "Laboratory",
                value: "MediCare Laboratory",
                valueColor: Color(uiColor: .label)
            )
            
            Divider().padding(.leading, 64)
            
            SuccessDetailRow(
                icon: "clock.fill",
                title: "Est. Ready",
                value: "Within 2 hours",
                valueColor: Color(uiColor: .systemGreen)
            )
            
            Divider().padding(.leading, 64)
            
            SuccessDetailRow(
                icon: "banknote.fill",
                title: "Report Price",
                value: "$45.00",
                valueColor: Color(uiColor: .label)
            )
        }
        .padding(.vertical, 8)
       
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 8)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.05), lineWidth: 1)
        )
    }
}


struct SuccessDetailRow: View {
    let icon: String
    let title: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
          
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemBlue).opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.body)
                    // Subdued blue matching the design
                    .foregroundStyle(Color(uiColor: .systemBlue).opacity(0.6))
            }
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(valueColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    SampleSuccessView()
}
