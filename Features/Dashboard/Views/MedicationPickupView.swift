//import SwiftUI
//import CoreImage.CIFilterBuiltins
//
//struct MedicationPickupView: View {
//    @Environment(\.dismiss) var dismiss
//    
//    let medicineName: String = "Amoxicillin 500mg"
//    let orderID: String = "#MED-7742"
//    
//    @State private var scanOffset: CGFloat = -100
//    @State private var showScanLine = true
//    
//   
//    @State private var navigateToPaymentView = false
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            
//            headerView
//            
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 32) {
//                    
//                    // Title
//                    VStack(spacing: 8) {
//                        Text("Medication Pickup")
//                            .font(.title2)
//                            .bold()
//                            .foregroundStyle(Color(uiColor: .label))
//                        
//                        Text("Scan this code at the pharmacy counter")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                    }
//                    .padding(.top, 20)
//                    
//                    // QR Code
//                    qrCodeContainer
//                    
//                    // Info Card
//                    medicationInfoCard
//                    
//                    Spacer(minLength: 40)
//                }
//                .padding()
//            }
//            
//            // Manual Done Button
//            Button {
//                navigateToPaymentView = true
//            } label: {
//                Text("Done")
//                    .font(.headline)
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//            }
//            .padding()
//            .padding(.bottom, 10)
//        }
//        .background(Color(uiColor: .systemGroupedBackground))
//        .navigationBarHidden(true)
//        .onAppear {
//            startScanLogic()
//        }
//        // 🔴 FIXED: Updated to match your exact variable name ($navigateToPaymentView)
//        .navigationDestination(isPresented: $navigateToPaymentView) {
//            PaymentView(
//                doctor: Doctor(name: "Dr. Michael Chen", specialty: "Pediatrician", rating: 4.8, reviewCount: 90, fee: 100, image: "doctor1", status: "Available", statusColor: .green, isBookable: true),
//                selectedDate: Date(),
//                selectedTime: "10:30 AM"
//            )
//        }
//    } // 🔴 FIXED: Added the missing closing bracket for the body property
//
//    // MARK: - Logic
//    private func startScanLogic() {
//        // 1. Start Animation Loop
//        // (The visual animation is handled in the .onAppear of the Rectangle below)
//        
//        // 2. Schedule the Navigation Trigger
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            
//            // Step A: Fade out the laser (Visual only)
//            withAnimation(.easeOut(duration: 0.5)) {
//                self.showScanLine = false
//            }
//            
//            // Step B: Trigger Navigation (SEPARATE from animation block)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                // 🔴 FIXED: Pointed this to PaymentView instead of Pharmacy
//                self.navigateToPaymentView = true
//            }
//        }
//    }
//    
//    // MARK: - Subviews
//    
//    private var headerView: some View {
//        HStack {
//            Button { dismiss() } label: {
//                HStack(spacing: 4) {
//                    Image(systemName: "chevron.left")
//                    Text("Back")
//                }
//                .font(.body).foregroundStyle(.blue)
//            }
//            Spacer()
//            Text("Medication").font(.headline).bold().padding(.trailing, 40)
//            Spacer()
//        }
//        .padding()
//        .background(Color(uiColor: .systemBackground))
//    }
//    
//    private var qrCodeContainer: some View {
//        ZStack {
//           
//            RoundedRectangle(cornerRadius: 24)
//                .fill(Color.white)
//                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
//                .frame(width: 300, height: 300)
//            
//            RoundedRectangle(cornerRadius: 20)
//                .fill(Color.teal.opacity(0.8))
//                .frame(width: 260, height: 260)
//            
//            RoundedRectangle(cornerRadius: 30)
//                .fill(Color.white)
//                .frame(width: 180, height: 180)
//                .shadow(color: .black.opacity(0.1), radius: 5)
//            
//            // QR Image
//            Image(uiImage: generateQRCode(from: "\(orderID)-\(medicineName)"))
//                .resizable()
//                .interpolation(.none)
//                .scaledToFit()
//                .frame(width: 140, height: 140)
//            
//            // Laser Animation
//            if showScanLine {
//                Rectangle()
//                    .fill(
//                        LinearGradient(
//                            colors: [.blue.opacity(0), .blue, .blue.opacity(0)],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
//                    .frame(width: 240, height: 3)
//                    .shadow(color: .blue.opacity(0.5), radius: 5, x: 0, y: 0)
//                    .offset(y: scanOffset)
//                    .onAppear {
//                        // Continuous Loop Animation
//                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
//                            scanOffset = 110
//                        }
//                    }
//            }
//            
//            VStack {
//                Text("Medication Ref:")
//                    .font(.system(size: 8))
//                    .foregroundStyle(.secondary)
//                    .offset(y: -80)
//            }
//            
//            ScannerCorners()
//                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
//                .frame(width: 260, height: 260)
//        }
//    }
//    
//    private var medicationInfoCard: some View {
//        HStack(spacing: 16) {
//            ZStack {
//                Circle().fill(Color.blue.opacity(0.1)).frame(width: 50, height: 50)
//                Image(systemName: "flask.fill").font(.title3).foregroundStyle(.blue)
//            }
//            VStack(alignment: .leading, spacing: 4) {
//                Text(medicineName).font(.headline).foregroundStyle(Color(uiColor: .label))
//                Text("2 Refills Remaining").font(.caption).foregroundStyle(.secondary)
//                Divider().padding(.vertical, 4)
//                HStack {
//                    Text("ORDER ID").font(.caption2).fontWeight(.bold).foregroundStyle(.gray.opacity(0.6))
//                    Spacer()
//                    Text(orderID).font(.caption2).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
//                }
//            }
//        }
//        .padding(16)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 16))
//        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
//    }
//    
//    // MARK: - Helpers
//    func generateQRCode(from string: String) -> UIImage {
//        let context = CIContext()
//        let filter = CIFilter.qrCodeGenerator()
//        filter.message = Data(string.utf8)
//        if let outputImage = filter.outputImage {
//            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgimg)
//            }
//        }
//        return UIImage(systemName: "xmark.circle") ?? UIImage()
//    }
//}
//
//// Custom Shape
//struct ScannerCorners: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let length: CGFloat = 30
//        
//        path.move(to: CGPoint(x: rect.minX, y: rect.minY + length))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.minY))
//        
//        path.move(to: CGPoint(x: rect.maxX - length, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + length))
//        
//        path.move(to: CGPoint(x: rect.minX, y: rect.maxY - length))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.minX + length, y: rect.maxY))
//        
//        path.move(to: CGPoint(x: rect.maxX - length, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - length))
//        
//        return path
//    }
//}
//
//#Preview {
//    NavigationStack {
//        MedicationPickupView()
//    }
//}

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MedicationPickupView: View {
    @Environment(\.dismiss) var dismiss
    
    let medicineName: String = "Amoxicillin 500mg"
    let orderID: String = "#MED-7742"
    
    @State private var scanOffset: CGFloat = -100
    @State private var showScanLine = true
    
    // State to trigger navigation to PaymentView
    @State private var navigateToPaymentView = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    // Title
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
                    
                    // QR Code
                    qrCodeContainer
                    
                    // Info Card
                    medicationInfoCard
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // Manual Done Button
            Button {
                navigateToPaymentView = true
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
        // 🔴 CRITICAL FIX: Routes to PaymentView with the .pharmacy flag
        .navigationDestination(isPresented: $navigateToPaymentView) {
            PaymentView(
                doctor: Doctor(name: "Dr. Michael Chen", specialty: "Pediatrician", rating: 4.8, reviewCount: 90, fee: 100, image: "Image (2)", status: "Available", statusColor: .green, isBookable: true),
                selectedDate: Date(),
                selectedTime: "10:30 AM",
                flowType: .pharmacy // <--- PREVENTS OVERLAP WITH LAB FLOW
            )
        }
    }

    // MARK: - Logic
    private func startScanLogic() {
        // 1. Start Animation Loop handled in .onAppear below
        
        // 2. Schedule the Navigation Trigger for 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            // Step A: Fade out the laser (Visual only)
            withAnimation(.easeOut(duration: 0.5)) {
                self.showScanLine = false
            }
            
            // Step B: Trigger Navigation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigateToPaymentView = true
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
            
            // QR Image
            Image(uiImage: generateQRCode(from: "\(orderID)-\(medicineName)"))
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
                        // Continuous Loop Animation
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            scanOffset = 110
                        }
                    }
            }
            
            VStack {
                Text("Medication Ref:")
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
                    .offset(y: -80)
            }
            
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
    
    // MARK: - Helpers
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

// Custom Shape
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
    NavigationStack {
        MedicationPickupView()
    }
}
