import SwiftUI

struct LabReportSampleView: View {
    @Environment(\.dismiss) var dismiss
    
 
    @State private var showShareSheet = false
    
 
    @State private var navigateToSuccess = false
    
    var body: some View {
        VStack(spacing: 0) {
            
         
            headerView
            
          
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    patientInfoCard
                    visitDetailsCard
                    samplesListCard
                    attendingDoctorCard
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            
           
            footerActionsView
        }
        .navigationBarHidden(true)
        
      
        .navigationDestination(isPresented: $navigateToSuccess) {
            SampleSuccessView()
        }
        
     
        .sheet(isPresented: $showShareSheet) {
            LabReportShareSheet(
                onAppIconTapped: {
                    navigateToSuccess = true
                }
            )
            .presentationDetents([.height(480)])
            .presentationDragIndicator(.visible)
        }
    }
    

    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: { Image(systemName: "chevron.left").font(.title3).fontWeight(.semibold).foregroundStyle(Color(uiColor: .systemBlue)) }
            Spacer()
            Text("Lab Report sample").font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
            Spacer()
            Button { } label: { Image(systemName: "ellipsis").font(.title3).foregroundStyle(Color(uiColor: .label)) }
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var patientInfoCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(Color.orange.opacity(0.2)).frame(width: 60, height: 60)
                Image(systemName: "person.crop.circle.fill").resizable().foregroundStyle(.orange).frame(width: 60, height: 60)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("xyz abdc").font(.title3).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                Text("Age 25 | ID: OPD-10293").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
        }
        .padding(20).background(Color(uiColor: .systemBlue).opacity(0.08)).clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var visitDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("VISIT DETAILS").font(.caption).fontWeight(.bold).foregroundStyle(Color(uiColor: .systemBlue)).tracking(1.0)
            VStack(spacing: 12) {
                LabReportDetailRow(title: "Visit Date", value: "Oct 24, 2023")
                Divider()
                LabReportDetailRow(title: "Department", value: "General Medicine")
                Divider()
                LabReportDetailRow(title: "Consultation #", value: "REF-8829")
            }
        }
        .padding(20).background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var samplesListCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Samples").font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                Spacer()
                Capsule().fill(Color(uiColor: .systemBlue)).frame(width: 48, height: 22)
            }.padding(16)
            
            Divider()
            
            LabSampleInstructionBlock(title: "Blood sample for diabetic report", instructions: [("clock", "8 hours not get food and drink water")])
            Divider().padding(.leading, 16)
            LabSampleInstructionBlock(title: "Urine sample for kidney report", instructions: [("wineglass", "Drink plenty of water"), ("fork.knife", "Skip the heavy meat dinner"), ("pills", "Hold off on painkillers")])
            Divider().padding(.leading, 16)
            LabSampleInstructionBlock(title: "Phlegm sample for lung report", instructions: [("smoke", "Skip the smoke before 8 hours"), ("tshirt", "Wear loose clothing")])
        }
        .background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var attendingDoctorCard: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("ATTENDING DOCTOR").font(.caption).fontWeight(.bold).foregroundStyle(Color(uiColor: .systemBlue)).tracking(1.0)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dr. Samantha Perera").font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                    Text("Internal Medicine").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("SLMC No: 45229").font(.caption).foregroundStyle(Color(uiColor: .tertiaryLabel))
                }
            }
            Spacer()
            VStack(spacing: 6) {
                ZStack { RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .systemGray6)).frame(width: 64, height: 64); Image(systemName: "checkmark.seal.fill").font(.title).foregroundStyle(Color(uiColor: .systemTeal)) }
                Text("Digitally Signed").font(.system(size: 10)).foregroundStyle(Color(uiColor: .tertiaryLabel))
            }
        }
        .padding(20).background(Color(uiColor: .secondarySystemGroupedBackground)).clipShape(RoundedRectangle(cornerRadius: 16)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
    }
    
    private var footerActionsView: some View {
        VStack(spacing: 16) {
            Button {
                showShareSheet = true
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share sample details")
                }
                .font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(.vertical, 16).background(Color(uiColor: .systemBlue)).clipShape(RoundedRectangle(cornerRadius: 16)).shadow(color: Color(uiColor: .systemBlue).opacity(0.3), radius: 8, x: 0, y: 4)
            }
            
            Button { } label: { HStack { Image(systemName: "doc.text"); Text("Download PDF") }.font(.headline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label)).frame(maxWidth: .infinity).padding(.vertical, 8) }
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 24).background(Color(uiColor: .systemBackground)).clipShape(RoundedRectangle(cornerRadius: 24)).shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
    }
}


struct LabReportShareSheet: View {
    @Environment(\.dismiss) var dismiss
    
  
    var onAppIconTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            
  
            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(uiColor: .systemBlue).opacity(0.1))
                        .frame(width: 48, height: 56)
                    
                    Image(systemName: "doc.text")
                        .font(.title2)
                        .foregroundStyle(Color(uiColor: .systemBlue))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Lab_Report_Samples.pdf")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(1)
                    
                    Text("PDF Document • 1.2 MB")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.bold())
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .frame(width: 32, height: 32)
                        .background(Color(uiColor: .systemGray6))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            
    
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                 
                    let tapAction = {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onAppIconTapped()
                        }
                    }
                    
                    LabShareAppIcon(title: "AirDrop", icon: "airdrop", iconColor: Color(uiColor: .systemBlue), bgColor: .white, action: tapAction)
                    LabShareAppIcon(title: "WhatsApp", icon: "message.fill", iconColor: .white, bgColor: Color(uiColor: .systemGreen), action: tapAction)
                    LabShareAppIcon(title: "Gmail", icon: "envelope.fill", iconColor: .white, bgColor: Color(uiColor: .systemRed), action: tapAction)
                    LabShareAppIcon(title: "Drive", icon: "externaldrive.fill", iconColor: .white, bgColor: Color(uiColor: .systemYellow), action: tapAction)
                    LabShareAppIcon(title: "Bluetooth", icon: "network", iconColor: .white, bgColor: Color(uiColor: .systemBlue), action: tapAction)
                }
                .padding(.horizontal, 20)
            }
            
            VStack(spacing: 0) {
                LabShareActionRow(title: "Copy", icon: "doc.on.doc")
                Divider().padding(.leading, 16)
                LabShareActionRow(title: "Save as PDF", icon: "doc.text")
                Divider().padding(.leading, 16)
                LabShareActionRow(title: "Save to Files", icon: "folder")
                Divider().padding(.leading, 16)
                LabShareActionRow(title: "Print", icon: "printer")
            }
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 20)
            .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
            
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}



struct LabShareAppIcon: View {
    let title: String
    let icon: String
    let iconColor: Color
    let bgColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(bgColor)
                        .frame(width: 60, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.2), lineWidth: bgColor == .white ? 1 : 0)
                        )
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(iconColor)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .label))
            }
        }
        .buttonStyle(.plain) // Keeps the custom styling intact
    }
}

struct LabShareActionRow: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button {
            // Standard action list
        } label: {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
        }
    }
}



struct LabReportDetailRow: View {
    let title: String; let value: String
    var body: some View { HStack { Text(title).font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel)); Spacer(); Text(value).font(.subheadline).fontWeight(.medium).foregroundStyle(Color(uiColor: .label)) } }
}

struct LabSampleInstructionBlock: View {
    let title: String; let instructions: [(icon: String, text: String)]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.subheadline).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
            VStack(alignment: .leading, spacing: 8) {
                ForEach(instructions, id: \.text) { instruction in
                    HStack(alignment: .top, spacing: 10) { Image(systemName: instruction.icon).font(.callout).foregroundStyle(Color(uiColor: .systemBlue)).frame(width: 20); Text(instruction.text).font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel)) }
                }
            }
        }.padding(16)
    }
}

#Preview {
    NavigationStack {
        LabReportSampleView()
    }
}
