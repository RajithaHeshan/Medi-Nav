


import SwiftUI

struct LaboratorySampleSubmissionView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var queueNumber = 5
    @State private var waitTime = 15
    
    @State private var navigateToLabSamplePickup = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        
                        visitLaboratoryCard
                        
                        personnelCard
                        
                        bloodSampleCard
                        
                        urineSampleCard
                        
                        Spacer(minLength: 140)                     }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
            
          
            VStack(spacing: 0) {
                Divider()
                VStack(spacing: 12) {
                    if queueNumber == 0 {
                        Text("It's your turn! Please proceed to the lab desk.")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.green)
                    } else {
                        Text("Please wait until your number is called.")
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                    
                    Button {
                        navigateToLabSamplePickup = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "qrcode.viewfinder")
                                .font(.title3)
                            Text("Scan QR Code")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(queueNumber == 0 ? Color.blue : Color.gray.opacity(0.4))
                        .clipShape(Capsule())
                        .shadow(color: queueNumber == 0 ? Color.blue.opacity(0.3) : .clear, radius: 8, y: 4)
                    }
                    .disabled(queueNumber > 0)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 24)
                .background(Color(uiColor: .systemBackground))
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
        
      
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    queueNumber = 0
                    waitTime = 0
                }
            }
        }
        
      
        .navigationDestination(isPresented: $navigateToLabSamplePickup) {
            LabSamplePickupView()
        }
    }
    
  
    
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
            
            Text("Laboratory Sample")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .font(.title2)
                .opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var visitLaboratoryCard: some View {
        VStack(alignment: .leading, spacing: 16) {
        
            HStack {
                Text("Visit Laboratory")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Text("10:30 AM")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(uiColor: .systemBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
            
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
            
          
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill")
                        .font(.title3)
                        .foregroundStyle(queueNumber == 0 ? .green : Color(uiColor: .systemBlue))
                    Text("\(queueNumber) Queue")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                        .contentTransition(.numericText())
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    Image(systemName: "hourglass")
                        .font(.title3)
                        .foregroundStyle(queueNumber == 0 ? .green : .brown)
                    Text("\(waitTime) mins")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                        .contentTransition(.numericText())
                }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
           
            HStack {
                Text("Please proceed when called")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button {
                
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
         
            HStack(spacing: 16) {
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
            
          
            HStack(spacing: 16) {
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
            iconBackground: Color(uiColor: .systemRed).opacity(0.1)
        )
    }
    
    private var urineSampleCard: some View {
        SampleTaskCard(
            title: "Provide Urine Sample",
            description: "Standard collection container provided at desk.",
            icon: "flask.fill",
            iconColor: .orange,
            iconBackground: Color.orange.opacity(0.1)
        )
    }
}

fileprivate struct SampleTaskCard: View {
    let title: String
    let description: String
    let icon: String
    let iconColor: Color
    let iconBackground: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
       
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
