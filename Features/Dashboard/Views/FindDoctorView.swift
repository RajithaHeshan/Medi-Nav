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
    @State private var selectedCategory = "All"
    
    private let categories = ["All", "Cardiology", "Dentist", "Neurology"]
    

    private let doctors = [
        Doctor(
            name: "Dr. Sarah Jenkins",
            specialty: "Cardiologist",
            rating: 4.9,
            reviewCount: 120,
            fee: 150,
            image: "doctor1",
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. Mike Ross",
            specialty: "Neurologist",
            rating: 4.8,
            reviewCount: 98,
            fee: 180,
            image: "doctor2",
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. Emily Clark",
            specialty: "Dentist",
            rating: 4.7,
            reviewCount: 65,
            fee: 120,
            image: "Image (2)",
            status: "Available Today",
            statusColor: .green,
            isBookable: true
        ),
        Doctor(
            name: "Dr. John Doe",
            specialty: "Cardiologist",
            rating: 4.9,
            reviewCount: 120,
            fee: 150,
            image: "Image (3)",
            status: "Next: Tue",
            statusColor: .gray,
            isBookable: false
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
               
                HStack {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                        TextField("Search doctors...", text: $searchText)
                    }
                    .padding(10)
                    .background(Color(uiColor: .systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
              
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 16)
                
               
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(doctors) { doctor in
                            DoctorRowItem(doctor: doctor)
                            Divider().padding(.leading, 80)
                        }
                    }
                }
            }
            .navigationTitle("Find a Doctor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left").bold()
                    }
                }
            }
        }
    }
}


struct DoctorRowItem: View {
    let doctor: Doctor
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            
            // 🔴 UPDATED AVATAR LOGIC
            ZStack {
                Circle()
                    .fill(Color(uiColor: .systemGray6))
                    .frame(width: 60, height: 60)
                
                // We use Image(doctor.image) to load from Assets
                Image(doctor.image)
                    .resizable()        // Allow resizing
                    .scaledToFill()     // Fill the circle properly
                    .frame(width: 60, height: 60)
                    .clipShape(Circle()) // Cut off corners to make it round
            }
            
           
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name)
                    .font(.headline)
                    .foregroundStyle(Color(uiColor: .label))
                
                Text(doctor.specialty)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
               
                HStack(spacing: 4) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(doctor.statusColor)
                    
                    Text(doctor.status)
                        .font(.caption)
                        .foregroundStyle(doctor.statusColor)
                        .fontWeight(.medium)
                    
                    Text("• $\(doctor.fee)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            
            Button { } label: {
                Text(doctor.isBookable ? "Book" : "Wait")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(doctor.isBookable ? Color.blue : Color(uiColor: .systemGray5))
                    .foregroundStyle(doctor.isBookable ? .white : .gray)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    FindDoctorView()
}
