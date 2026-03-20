
import SwiftUI
import CoreImage.CIFilterBuiltins

struct LabSamplePickupView: View {
    @Environment(\.dismiss) var dismiss
    
   
    var sampleType: String = "Blood Sample"
    var sampleID: String = "#BLD-992"
    var instructions: String = "Requires 8 hours fasting before collection."
    var iconName: String = "drop.fill"
    var iconColor: Color = .red
    
   
    @State private var scanOffset: CGFloat = -100
    @State private var showScanLine = true
    
  
    @State private var navigateToPaymentView = false
    
    var body: some View {
        VStack(spacing: 0) {
            
        
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
           
                    VStack(spacing: 8) {
                        Text("Sample Submission")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color(uiColor: .label))
                        
                        Text("Scan this code at the laboratory desk")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
             
                    qrCodeContainer
                    

                    labSampleDetailsCard
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            

        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
        .onAppear {
            startScanLogic()
        }
        
        .navigationDestination(isPresented: $navigateToPaymentView) {
            PaymentView(
                doctor: Doctor(name: "Dr. Michael Chen", specialty: "Pediatrician", rating: 4.8, reviewCount: 90, fee: 45, image: "Image (2)", status: "Available", statusColor: .green, isBookable: true),
                selectedDate: Date(),
                selectedTime: "10:30 AM",
                flowType: .labReport // Prevents overlap with pharmacy flow!
            )
        }
    }
    
    private func startScanLogic() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
           
            withAnimation(.easeOut(duration: 0.3)) {
                self.showScanLine = false
            }
            
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigateToPaymentView = true
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
   
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.body).foregroundStyle(.blue)
            }
            Spacer()
            Text("Laboratory").font(.headline).bold().padding(.trailing, 40)
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var qrCodeContainer: some View {
        ZStack {
          
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                .frame(width: 300, height: 300)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.teal.opacity(0.8))
                .frame(width: 260, height: 260)
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: 180, height: 180)
                .shadow(color: .black.opacity(0.1), radius: 5)
            
           
            Image(uiImage: generateQRCode(from: "\(sampleID)-\(sampleType)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 140, height: 140)
            
        
            if showScanLine {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0), .blue, .blue.opacity(0)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 240, height: 3)
                    .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0)
                    .offset(y: scanOffset)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            scanOffset = 110
                        }
                    }
            }
            
            VStack {
                Text("Sample Ref:")
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
                    .offset(y: -80)
            }
            
          
            LabScannerCorners()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 260, height: 260)
        }
    }
    
    private var labSampleDetailsCard: some View {
        HStack(spacing: 16) {
            // Icon Box
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundStyle(iconColor)
            }
            
            // Text Info
            VStack(alignment: .leading, spacing: 4) {
                Text(sampleType)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(instructions)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider()
                    .padding(.vertical, 4)
                
                HStack {
                    Text("SAMPLE ID")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray.opacity(0.6))
                    
                    Spacer()
                    
                    Text(sampleID)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}


struct LabScannerCorners: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length: CGFloat = 30
        
      
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.minY))
        
       
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + length))
        
      
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.maxY))
        
       
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - length))
        
        return path
    }
}

#Preview {
    NavigationStack {
        LabSamplePickupView()
    }
}
