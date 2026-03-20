import SwiftUI

struct SampleCollectionSuccessView: View {
    @Environment(\.dismiss) var dismiss
    
    
    var sampleType: String = "Blood Sample"
    var sampleID: String = "#BLD-992"
    
    
    @State private var showCheck = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            VStack(spacing: 24) {
             
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 100, height: 100)
                        .scaleEffect(showCheck ? 1 : 0.5)
                        .opacity(showCheck ? 1 : 0)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.green)
                        .scaleEffect(showCheck ? 1 : 0.5)
                        .opacity(showCheck ? 1 : 0)
                }
                
                VStack(spacing: 8) {
                    Text("Sample Collected!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("Your \(sampleType.lowercased()) has been successfully registered in our system.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }
            .padding(.bottom, 40)
            
            // 2. Receipt Card
            VStack(spacing: 16) {
                HStack {
                    Text("Transaction ID")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(sampleID)
                        .fontWeight(.semibold)
                        .font(.system(.body, design: .monospaced))
                }
                
                Divider()
                
                HStack {
                    Text("Date & Time")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(Date().formatted(date: .abbreviated, time: .shortened))
                        .fontWeight(.medium)
                }
                
                Divider()
                
                HStack {
                    Text("Status")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("Processing")
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.1))
                        .clipShape(Capsule())
                }
            }
            .padding(20)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            
            Spacer()
            
           
            Button {
               
                print("Move to Lab Reports tapped")
              
            } label: {
                Text("Move to Lab Reports")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(20)
            .padding(.bottom, 10)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                showCheck = true
            }
        }
    }
}

#Preview {
    SampleCollectionSuccessView()
}

