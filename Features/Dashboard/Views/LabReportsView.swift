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
      
        case .ready: return Color(red: 0.0, green: 0.5, blue: 0.0)
        case .processing: return Color(red: 0.85, green: 0.4, blue: 0.0)
        case .archived: return Color(uiColor: .secondaryLabel)
        }
    }
    
    var bgColor: Color {
        switch self {
        case .ready: return Color.green.opacity(0.15)
        case .processing: return Color.orange.opacity(0.15)
        case .archived: return Color(uiColor: .systemGray5)
        }
    }
}

struct ReportItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let orderedBy: String
    let date: String
    let status: LabStatus
}

struct LabReportsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedReport: ReportItem?
    
   
    @State private var selectedFilter: String = "All"
    let filters = ["All", "Ready", "Processing", "Archived"]
    
   
    let reports = [
        ReportItem(title: "Blood Glucose", orderedBy: "Dr. Sarah Johnson", date: "Oct 24, 2023", status: .ready),
        ReportItem(title: "Complete Blood Count", orderedBy: "Dr. Sarah Johnson", date: "Oct 24, 2023", status: .processing),
        ReportItem(title: "Lipid Profile", orderedBy: "Dr. Sarah Johnson", date: "Oct 23, 2023", status: .processing),
        ReportItem(title: "Urinalysis Report", orderedBy: "Dr. Sarah Johnson", date: "Sep 10, 2023", status: .archived)
    ]
    

    var filteredReports: [ReportItem] {
        var result = reports
        
       
        if selectedFilter != "All" {
            result = result.filter { $0.status.title.contains(selectedFilter) }
        }
        
       
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.orderedBy.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
              
                headerView
         
                searchBar
                
                
                Picker("Filter Reports", selection: $selectedFilter) {
                    ForEach(filters, id: \.self) { filter in
                        Text(filter).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(filteredReports) { item in
                            LabReportRow(item: item) { selectedItem in
                                selectedReport = selectedItem
                            }
                        }
                        
                    
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 4)
                }
            }
        }
        .navigationBarHidden(true)
        
        
        .navigationDestination(item: $selectedReport) { report in
            LabReportDetailView(
                reportTitle: report.title,
                status: report.status
            )
            .navigationBarBackButtonHidden(true)
        }
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
            
            Text("Lab Reports")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
            
            TextField("Search by name or doctor...", text: $searchText)
            
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
}


struct LabReportRow: View {
    let item: ReportItem
    let action: (ReportItem) -> Void
    
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
                        Text(item.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(uiColor: .label))
                        Text(item.orderedBy)
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
            .padding(20)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20)) 
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}



#Preview {
    NavigationStack {
        LabReportsView()
    }
}
