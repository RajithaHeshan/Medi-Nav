import SwiftUI

struct MyPrescriptionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
            
                headerView
                
           
                searchBarView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        
                     
                        needsRefillSection
                        
                       
                        activeSection
                        
                      
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    
    
    private var headerView: some View {
        HStack(spacing: 16) {
            Button(action: { dismiss() }) {
                ZStack {
                    Circle()
                        .fill(Color(uiColor: .systemBackground))
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.blue)
                        .offset(x: -1.5)
                }
            }
            
            Text("My Prescription")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
            
            TextField("Search doctors...", text: $searchText)
            
            Spacer()
            
            if !searchText.isEmpty {
                Button(action: {
                    withAnimation { searchText = "" }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .font(.body.weight(.medium))
                }
            } else {
                Image(systemName: "mic.fill")
                    .foregroundStyle(Color(uiColor: .systemGray2))
                    .font(.body.weight(.medium))
            }
        }
        .padding(10)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
    
    private var needsRefillSection: some View {
        VStack(spacing: 16) {
           
            HStack {
                Image(systemName: "bell.fill")
                    .foregroundStyle(Color.red)
                Text("Needs Refill")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.red)
                
                Spacer()
                
                Text("2 Items")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
          
            VStack(spacing: 16) {
                
                PrescriptionActionCard(
                    title: "Lisinopril 10mg",
                    subtitle: "Twice a day • Before breakfast",
                    icon: "pill.fill",
                    iconColor: .pink,
                    statusText: "5 pills left • Critical stock",
                    statusColor: .red,
                    buttonTitle: "Quick Refill",
                    buttonIcon: "arrow.triangle.2.circlepath",
                    buttonBgColor: .blue,
                    buttonTextColor: .white,
                    action: { }
                )
                
               
                PrescriptionActionCard(
                    title: "Metformin 500mg",
                    subtitle: "Once a day • With dinner",
                    icon: "pills.fill",
                    iconColor: .orange,
                    statusText: "2 pills left • Refill requested",
                    statusColor: .orange,
                    buttonTitle: "Request Sent",
                    buttonIcon: "checkmark.circle.fill",
                    buttonBgColor: Color(uiColor: .systemGray5),
                    buttonTextColor: Color(uiColor: .secondaryLabel), // Adjusted for elder contrast
                    action: { }
                )
            }
        }
    }
    
    private var activeSection: some View {
        VStack(spacing: 16) {
          
            HStack {
                Image(systemName: "archivebox.fill")
                    .foregroundStyle(Color(uiColor: .systemGray))
                Text("Active")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Text("1 Item")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
            // Active Card
            VStack(spacing: 16) {
                HStack(alignment: .top, spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: 56, height: 56)
                        Image(systemName: "cross.vial.fill")
                            .font(.title2)
                            .foregroundStyle(Color.blue)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Atorvastatin 20mg")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(uiColor: .label))
                        
                        Text("Every evening")
                            .font(.subheadline)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Quantity")
                            .font(.caption2)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                        Text("28 left")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.blue)
                    }
                }
                
                // Custom Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.blue.opacity(0.15))
                            .frame(height: 6)
                        
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: geometry.size.width * 0.75, height: 6) // Represents 28/~30 pills
                    }
                }
                .frame(height: 6)
                .padding(.top, 4)
            }
            .padding(20)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.15), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        }
    }
}


struct PrescriptionActionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color
    let statusText: String
    let statusColor: Color
    let buttonTitle: String
    let buttonIcon: String
    let buttonBgColor: Color
    let buttonTextColor: Color
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
           
            HStack(alignment: .top, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 56, height: 56)
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    
                    HStack(spacing: 6) {
                        Circle()
                            .fill(statusColor)
                            .frame(width: 6, height: 6)
                        Text(statusText)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(statusColor)
                    }
                    .padding(.top, 4)
                }
                Spacer()
            }
            
     
            Button(action: action) {
                HStack(spacing: 8) {
                    Text(buttonTitle)
                    Image(systemName: buttonIcon)
                }
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(buttonTextColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(buttonBgColor)
                .clipShape(Capsule())
            }
           
            .disabled(buttonBgColor == Color(uiColor: .systemGray5))
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.15), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        MyPrescriptionView()
    }
}


