
import SwiftUI

struct MyPrescriptionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    // MARK: - Navigation State
    @State private var selectedMedicine: String? // Triggers navigation
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        searchBar
                        needsRefillSection
                        activeSection
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // MARK: - Destination
            .navigationDestination(item: $selectedMedicine) { medicineName in
                // Navigate to Details with data
                PrescriptionDetailView(
                    medicineName: medicineName,
                    status: medicineName.contains("Lisinopril") ? "Critical Stock" : "Active",
                    statusColor: medicineName.contains("Lisinopril") ? .red : .blue
                )
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            Text("My Prescription").font(.headline).bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding().background(Color(uiColor: .systemBackground))
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass").foregroundStyle(.gray)
            TextField("Search by name or specialty...", text: $searchText)
        }
        .padding(14).background(Color(uiColor: .secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var needsRefillSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "bell.fill").foregroundStyle(.red)
                Text("Needs Refill").font(.headline).foregroundStyle(.red)
                Spacer()
                Text("2 Items").font(.caption).foregroundStyle(.secondary)
            }
            
            // Card 1: Lisinopril
            PrescriptionCard {
                // Trigger Navigation when clicked
                selectedMedicine = "Lisinopril 10mg"
            } content: {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.red.opacity(0.1)).frame(width: 50, height: 50)
                            Image(systemName: "cross.case.fill").font(.title3).foregroundStyle(.red)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lisinopril 10mg").font(.headline).foregroundStyle(Color(uiColor: .label))
                            Text("Twice a day • Before breakfast").font(.caption).foregroundStyle(.secondary)
                            HStack(spacing: 4) {
                                Circle().fill(Color.red).frame(width: 6, height: 6)
                                Text("5 pills left • Critical stock").font(.caption).fontWeight(.semibold).foregroundStyle(.red)
                            }
                            .padding(.top, 2)
                        }
                        Spacer()
                        // 🔴 VECTOR ICON (Chevron)
                        Image(systemName: "chevron.right")
                            .font(.body)
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                    
                    Button { /* Quick Refill Logic */ } label: {
                        HStack { Text("Quick Refill"); Image(systemName: "arrow.clockwise") }
                            .font(.subheadline).fontWeight(.semibold).foregroundStyle(.white)
                            .frame(maxWidth: .infinity).padding(.vertical, 12)
                            .background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            
            // Card 2: Metformin
            PrescriptionCard {
                 selectedMedicine = "Metformin 500mg"
            } content: {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.orange.opacity(0.1)).frame(width: 50, height: 50)
                            Image(systemName: "cross.case.fill").font(.title3).foregroundStyle(.orange)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Metformin 500mg").font(.headline).foregroundStyle(Color(uiColor: .label))
                            Text("Once a day • With dinner").font(.caption).foregroundStyle(.secondary)
                            HStack(spacing: 4) {
                                Circle().fill(Color.orange).frame(width: 6, height: 6)
                                Text("2 pills left • Refill requested").font(.caption).fontWeight(.semibold).foregroundStyle(.orange)
                            }
                            .padding(.top, 2)
                        }
                        Spacer()
                        // 🔴 VECTOR ICON
                        Image(systemName: "chevron.right")
                            .font(.body)
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                    
                    Button {} label: {
                        HStack { Text("Request Sent"); Image(systemName: "checkmark.circle.fill") }
                            .font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity).padding(.vertical, 12)
                            .background(Color(uiColor: .systemGray5)).clipShape(RoundedRectangle(cornerRadius: 12))
                    }.disabled(true)
                }
            }
        }
    }
    
    private var activeSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "archivebox.fill").foregroundStyle(.gray)
                Text("Active").font(.headline).foregroundStyle(Color(uiColor: .label))
                Spacer()
                Text("1 Item").font(.caption).foregroundStyle(.secondary)
            }
            
            // Card 3: Atorvastatin
            PrescriptionCard {
                 selectedMedicine = "Atorvastatin 20mg"
            } content: {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12).fill(Color.blue.opacity(0.1)).frame(width: 50, height: 50)
                            Image(systemName: "ivfluid.bag.fill").font(.title3).foregroundStyle(.blue)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Atorvastatin 20mg").font(.headline).foregroundStyle(Color(uiColor: .label))
                            Text("Every evening").font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            // 🔴 VECTOR ICON
                            Image(systemName: "chevron.right").font(.body).foregroundStyle(.gray.opacity(0.5)).padding(.bottom, 8)
                            
                            Text("Quantity").font(.caption2).foregroundStyle(.secondary)
                            Text("28 left").font(.subheadline).fontWeight(.bold).foregroundStyle(.blue)
                        }
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.gray.opacity(0.1)).frame(height: 6)
                            Capsule().fill(Color.blue).frame(width: geo.size.width * 0.85, height: 6)
                        }
                    }.frame(height: 6)
                }
            }
        }
    }
}

// MARK: - Updated Helper Card
struct PrescriptionCard<Content: View>: View {
    let action: () -> Void
    let content: Content
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }
    
    var body: some View {
        Button(action: action) {
            content
                .padding(16)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.05), lineWidth: 1))
        }
        .buttonStyle(PlainButtonStyle()) // Keeps standard button press behavior
    }
}

#Preview {
    MyPrescriptionView()
}
