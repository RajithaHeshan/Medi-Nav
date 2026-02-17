
import SwiftUI

struct LabReportsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            headerView
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // 2. Search Bar
                    searchBar
                    
                    // 3. Hero Summary Card
                    heroSummaryCard
                    
                    // 4. Reports List
                    VStack(spacing: 16) {
                        // Card 1: Results Ready
                        LabReportCard(
                            title: "Blood Glucose",
                            orderedBy: "Dr. Sarah Johnson",
                            date: "Oct 24, 2023",
                            status: .ready
                        )
                        
                        // Card 2: Processing
                        LabReportCard(
                            title: "Complete Blood Count", // Example title
                            orderedBy: "Dr. Sarah Johnson",
                            date: "Oct 24, 2023",
                            status: .processing
                        )
                        
                        // Card 3: Archived
                        LabReportCard(
                            title: "Urinalysis Report", // Example title
                            orderedBy: "Dr. Sarah Johnson",
                            date: "Oct 24, 2023",
                            status: .archived
                        )
                    }
                    
                    Spacer(minLength: 20)
                    
                    // 5. Download Button
                    Button {
                        // Action: Download
                    } label: {
                        HStack(spacing: 8) {
                            Text("Download All Reports")
                            Image(systemName: "arrow.down.to.line")
                        }
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).bold()
                    .foregroundStyle(.black)
            }
            Spacer()
            Text("Lab Reports")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            TextField("Search by name or specialty...", text: $searchText)
        }
        .padding(14)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var heroSummaryCard: some View {
        HStack(spacing: 16) {
            // Icon Area
            ZStack {
                Circle()
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 56, height: 56)
                
                Image(systemName: "flask.fill")
                    .font(.title2)
                    .foregroundStyle(.orange)
            }
            .overlay(
                Circle()
                    .stroke(Color.orange.opacity(0.2), lineWidth: 1) // Dashed effect simulation
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("You have 3 active lab requests")
                    .font(.subheadline) // Slightly smaller than headline for better fit
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Last updated: just now")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Lab Report Card Component
struct LabReportCard: View {
    let title: String
    let orderedBy: String
    let date: String
    let status: LabStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Top Row: Status & Date
            HStack {
                Text(status.title)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(status.textColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(status.bgColor)
                    .clipShape(Capsule())
                
                Spacer()
                
                Text(date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // Middle Row: Info & Chevron
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("Ordered by \(orderedBy)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray.opacity(0.5))
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        // Subtle stroke for definition
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.05), lineWidth: 1)
        )
        // Soft shadow
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Enums & Models
enum LabStatus {
    case ready
    case processing
    case archived
    
    var title: String {
        switch self {
        case .ready: return "Results Ready"
        case .processing: return "Processing"
        case .archived: return "Archived"
        }
    }
    
    var textColor: Color {
        switch self {
        case .ready: return .green
        case .processing: return .orange
        case .archived: return .gray
        }
    }
    
    var bgColor: Color {
        switch self {
        case .ready: return .green.opacity(0.1)
        case .processing: return .orange.opacity(0.1)
        case .archived: return Color(uiColor: .systemGray5)
        }
    }
}

#Preview {
    LabReportsView()
}
