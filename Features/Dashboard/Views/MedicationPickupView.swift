import SwiftUI
import CoreImage.CIFilterBuiltins

struct MedicationPickupView: View {
    @Environment(\.dismiss) var dismiss
    
  
    let medicineName: String = "Amoxicillin 500mg"
    let orderID: String = "#MED-7742"
    
    var body: some View {
        VStack(spacing: 0) {
            
           
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
                    
                    // 3. QR Code Scanner Visual
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
        .background(Color(uiColor: .systemGroupedBackground)) // Light gray background
        .navigationBarHidden(true)
    }
    
   
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .font(.body)
                .foregroundStyle(.blue)
            }
            
            Spacer()
            
            Text("Medication")
                .font(.headline)
                .bold()
                .padding(.trailing, 40)
            
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
                .fill(Color.teal.opacity(0.8)) // Matching the teal in screenshot
                .frame(width: 260, height: 260)
            
            // White Organic Shape / Container for QR
            RoundedRectangle(cornerRadius: 30) // Using high corner radius for "blob" look
                .fill(Color.white)
                .frame(width: 180, height: 180)
                .shadow(color: .black.opacity(0.1), radius: 5)
            
            // Actual Generated QR Code
            Image(uiImage: generateQRCode(from: "\(orderID)-\(medicineName)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 140, height: 140)
            
            // Text above QR (Tiny detail from screenshot)
            VStack {
                Text("Medication Catural:")
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
            // Icon
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "flask.fill")
                    .font(.title3)
                    .foregroundStyle(.blue)
            }
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(medicineName)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text("2 Refills Remaining")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Divider()
                    .padding(.vertical, 4)
                
                HStack {
                    Text("ORDER ID")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray.opacity(0.6))
                    
                    Spacer()
                    
                    Text(orderID)
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
    
    // MARK: - Helper Functions
    
    // Generates a real QR code from a string
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


struct ScannerCorners: Shape {
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
    MedicationPickupView()
}
