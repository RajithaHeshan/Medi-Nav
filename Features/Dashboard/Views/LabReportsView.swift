import SwiftUI


enum LabStatus: String, CaseIterable, Hashable {
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
        case .ready: return Color.green
        case .processing: return Color.orange
        case .archived: return Color.gray
        }
    }
    
    var bgColor: Color {
        switch self {
        case .ready: return Color.green.opacity(0.1)
        case .processing: return Color.orange.opacity(0.1)
        case .archived: return Color(uiColor: .systemGray5)
        }
    }
}

struct LabReportsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
  
    @State private var selectedReport: ReportItem?
    
 
    struct ReportItem: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let orderedBy: String
        let date: String
        let status: LabStatus
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // Search
                        searchBar
                        
                        // Summary Cards
                        summaryCardsScroll
                        
                        // Reports List
                        reportsList
                        
                        Spacer(minLength: 20)
                    }
                    .padding()
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
            
            // Destination -> Detail View
            .navigationDestination(item: $selectedReport) { report in
                LabReportDetailView(
                    reportTitle: report.title,
                    status: report.status
                )
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
   
    private var headerView: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left").font(.title3).bold().foregroundStyle(.black)
            }
            Spacer()
            Text("Lab Reports").font(.headline).bold()
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
    
    private var summaryCardsScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                SummaryCountCard(count: "01", title: "Results Ready", color: .green, icon: "checkmark.circle.fill")
                SummaryCountCard(count: "02", title: "Processing", color: .orange, icon: "clock.fill")
                SummaryCountCard(count: "03", title: "Archived", color: .gray, icon: "archivebox.fill")
            }
            .padding(.horizontal, 4)
        }
    }
    
    private var reportsList: some View {
        VStack(spacing: 16) {
            // Sample Data Items
            LabReportRow(item: ReportItem(title: "Blood Glucose", orderedBy: "Dr. Sarah Johnson", date: "Oct 24, 2023", status: .ready)) { item in selectedReport = item }
            
            LabReportRow(item: ReportItem(title: "Complete Blood Count", orderedBy: "Dr. Sarah Johnson", date: "Oct 24, 2023", status: .processing)) { item in selectedReport = item }
            
            LabReportRow(item: ReportItem(title: "Lipid Profile", orderedBy: "Dr. Sarah Johnson", date: "Oct 23, 2023", status: .processing)) { item in selectedReport = item }
            
            LabReportRow(item: ReportItem(title: "Urinalysis Report", orderedBy: "Dr. Sarah Johnson", date: "Sep 10, 2023", status: .archived)) { item in selectedReport = item }
        }
    }
}

// MARK: - Components
struct SummaryCountCard: View {
    let count: String
    let title: String
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    Circle().fill(color.opacity(0.15)).frame(width: 36, height: 36)
                    Image(systemName: icon).font(.caption).foregroundStyle(color)
                }
                Spacer()
                Text(count).font(.title2).fontWeight(.bold).foregroundStyle(Color(uiColor: .label))
            }
            Text(title).font(.caption).fontWeight(.semibold).foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(width: 140, height: 100)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: 2)
    }
}

struct LabReportRow: View {
    let item: LabReportsView.ReportItem
    let action: (LabReportsView.ReportItem) -> Void
    
    var body: some View {
        Button { action(item) } label: {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(item.status.title)
                        .font(.caption2).fontWeight(.bold)
                        .foregroundStyle(item.status.textColor)
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(item.status.bgColor).clipShape(Capsule())
                    Spacer()
                    Text(item.date).font(.caption).foregroundStyle(.secondary)
                }
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title).font(.headline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label))
                        Text("Ordered by \(item.orderedBy)").font(.caption).foregroundStyle(.gray)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").font(.subheadline).fontWeight(.semibold).foregroundStyle(.gray.opacity(0.5))
                }
            }
            .padding(16).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LabReportsView()
}
