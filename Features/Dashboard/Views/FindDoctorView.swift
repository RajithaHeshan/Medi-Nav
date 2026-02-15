import SwiftUI


struct Doctor: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let reviewCount: Int
    let fee: Int
    let image: String
    let status: String
    let statusColor: Color
    let isBookable: Bool
}

struct FindDoctorView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedCategory = "All Doctors"
    
    
    private let categories = ["All Doctors", "Cardiology", "Dentist", "Neurology", "Orthopedic"]
    
    private let doctors = [
        Doctor(name: "Dr. Sarah Jenkins", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "person.fill", status: "AVAILABLE TODAY", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. Mike Ross", specialty: "Neurologist", rating: 4.8, reviewCount: 98, fee: 180, image: "person.fill", status: "AVAILABLE TODAY", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. Emily Clark", specialty: "Dentist", rating: 4.7, reviewCount: 65, fee: 120, image: "person.fill", status: "AVAILABLE TODAY", statusColor: .green, isBookable: true),
        Doctor(name: "Dr. John Doe", specialty: "Cardiologist", rating: 4.9, reviewCount: 120, fee: 150, image: "person.fill", status: "NEXT: TUE", statusColor: .gray, isBookable: false)
    ]
    
   
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
               
                VStack(spacing: 20) {
                    headerSection
                    searchBar
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // 4. Category Filter (Horizontal Scroll)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryPill(text: category, isSelected: selectedCategory == category) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(doctors) { doctor in
                            DoctorCard(doctor: doctor)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    
    
    private var headerSection: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color(uiColor: .label))
                    .padding(10)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
            }
            
            Text("Find a Doctor")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, 40)
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
                .font(.title3)
            
            TextField("Search by name or specialty...", text: $searchText)
                .font(.subheadline)
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        // Subtle shadow to lift it off the gray background
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}



struct CategoryPill: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.blue : Color.white)
                .foregroundStyle(isSelected ? .white : .gray)
                .clipShape(Capsule())
                // Border only for unselected items
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

struct DoctorCard: View {
    let doctor: Doctor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 1. Image & Status Badge
            ZStack(alignment: .top) {
                // Placeholder for Doctor Image
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .foregroundStyle(.gray.opacity(0.5))
                    )
                
                
                Text(doctor.status)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(doctor.statusColor)
                    .clipShape(Capsule())
                    .padding(.top, 12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
          
            VStack(alignment: .leading, spacing: 6) {
                Text(doctor.specialty)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.blue)
                
                Text(doctor.name)
                    .font(.headline)
                    .bold()
                    .foregroundStyle(Color(uiColor: .label))
                    .lineLimit(1)
                
              
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.caption)
                    Text("\(String(format: "%.1f", doctor.rating))")
                        .font(.caption)
                        .bold()
                    Text("(\(doctor.reviewCount))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Text("Fee: $\(doctor.fee)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            
           
            Button {
                
            } label: {
                Text(doctor.isBookable ? "Book Now" : "View Slots")
                    .font(.caption)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(doctor.isBookable ? Color.blue : Color.white)
                    .foregroundStyle(doctor.isBookable ? .white : .blue)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.blue, lineWidth: doctor.isBookable ? 0 : 1)
                    )
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    FindDoctorView()
    CustomTabBar(selectedTab: .constant(.home))
}
