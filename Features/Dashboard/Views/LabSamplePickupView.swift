


import SwiftUI
import CoreImage.CIFilterBuiltins

struct LabSamplePickupView: View {
    @Environment(\.dismiss) var dismiss
    
    // Data passed in (Defaulting to Blood Sample as per request)
    var sampleType: String = "Blood Sample"
    var sampleID: String = "#BLD-992"
    var instructions: String = "Requires 8 hours fasting before collection."
    var iconName: String = "drop.fill"
    var iconColor: Color = .red
    
    // MARK: - Animation State
    @State private var scanOffset: CGFloat = -100
    @State private var showScanLine = true
    
    // 🔴 NAVIGATION STATE
    @State private var navigateToSuccess = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    // 2. Title Section
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
                    
                    // 3. QR Code with Animation
                    qrCodeContainer
                    
                    // 4. Lab Sample Info Card
                    labSampleDetailsCard
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // 5. Manual Done Button (Optional Override)
            Button {
                navigateToSuccess = true
            } label: {
                Text("Done")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
            .padding(.bottom, 10)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
        .onAppear {
            startScanLogic()
        }
        // 🔴 6. NAVIGATION DESTINATION
        .navigationDestination(isPresented: $navigateToSuccess) {
            SampleCollectionSuccessView(
                sampleType: sampleType,
                sampleID: sampleID
            )
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Logic & Helpers
    
    private func startScanLogic() {
        // Run scan animation for 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            // Step A: Fade out the laser visuals
            withAnimation(.easeOut(duration: 0.5)) {
                self.showScanLine = false
            }
            
            // Step B: Trigger Navigation (Safe Delay)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigateToSuccess = true
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
    
    // MARK: - Subviews
    
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
            // Backgrounds
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
            
            // QR Code Image
            Image(uiImage: generateQRCode(from: "\(sampleID)-\(sampleType)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 140, height: 140)
            
            // Laser Animation
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
            
            // 🔴 Uses Renamed Shape
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

// 🔴 RENAMED SHAPE STRUCT (Fixed Error)
struct LabScannerCorners: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let length: CGFloat = 30
        
        // Top Left
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.minY))
        
        // Top Right
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + length))
        
        // Bottom Left
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - length))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.maxY))
        
        // Bottom Right
        path.move(to: CGPoint(x: rect.maxX - length, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - length))
        
        return path
    }
}

#Preview {
    LabSamplePickupView()
}
