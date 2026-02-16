import SwiftUI
import CoreImage.CIFilterBuiltins

struct MedicationPickupView: View {
    @Environment(\.dismiss) var dismiss
    
    // Data passed in
    let medicineName: String = "Amoxicillin 500mg"
    let orderID: String = "#MED-7742"
    
    // MARK: - Animation State
    @State private var isScanning = false
    @State private var scanOffset: CGFloat = -100 // Start position (Top)
    @State private var showScanLine = true // Visibility of the line
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    // 2. Title Section
                    VStack(spacing: 8) {
                        Text("Medication Pickup")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color(uiColor: .label))
                        
                        Text("Scan this code at the pharmacy counter")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // 3. QR Code with Animation
                    qrCodeContainer
                    
                    // 4. Medication Info Card
                    medicationInfoCard
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // 5. Done Button
            Button {
                dismiss()
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
            startScanAnimation()
        }
    }
    
    // MARK: - Animation Logic
    private func startScanAnimation() {
        // 1. Start the movement immediately
        isScanning = true
        
        // 2. Stop after 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            withAnimation(.easeOut(duration: 0.5)) {
                showScanLine = false // Fade out the laser
                isScanning = false   // Stop logic
            }
        }
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
            Text("Medication").font(.headline).bold().padding(.trailing, 40)
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var qrCodeContainer: some View {
        ZStack {
            // White Card Background
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                .frame(width: 300, height: 300)
            
            // Teal Background inside
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.teal.opacity(0.8))
                .frame(width: 260, height: 260)
            
            // White Container for QR
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .frame(width: 180, height: 180)
                .shadow(color: .black.opacity(0.1), radius: 5)
            
            // QR Code Image
            Image(uiImage: generateQRCode(from: "\(orderID)-\(medicineName)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 140, height: 140)
            
            // 🔴 THE SCANNING LASER ANIMATION
            if showScanLine {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0), .blue, .blue.opacity(0)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 240, height: 3) // Laser width
                    .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0) // Glow effect
                    .offset(y: scanOffset)
                    .onAppear {
                        // Animate from Top (-110) to Bottom (110)
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            scanOffset = 110
                        }
                    }
            }
            
            // Text above QR
            VStack {
                Text("Medication Ref:")
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
                    .offset(y: -80)
            }
            
            // Blue Corner Brackets (Viewfinder)
            ScannerCorners()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 260, height: 260)
        }
    }
    
    private var medicationInfoCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(Color.blue.opacity(0.1)).frame(width: 50, height: 50)
                Image(systemName: "flask.fill").font(.title3).foregroundStyle(.blue)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(medicineName).font(.headline).foregroundStyle(Color(uiColor: .label))
                Text("2 Refills Remaining").font(.caption).foregroundStyle(.secondary)
                Divider().padding(.vertical, 4)
                HStack {
                    Text("ORDER ID").font(.caption2).fontWeight(.bold).foregroundStyle(.gray.opacity(0.6))
                    Spacer()
                    Text(orderID).font(.caption2).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Helper Functions
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
}

// Custom Shape for Corners
struct ScannerCorners: Shape {
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
    MedicationPickupView()
}
