
import SwiftUI

struct VitalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK: - State
    @State private var selectedFilter = "All"
    
    // Filters Data
    let filters = ["All", "Blood Pressure", "Heart Rate", "Weight", "SpO2", "Body Temp"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 1. Header
            headerView
            
            // 2. Filter Bar (HIG Compliant Scrollable Chips)
            filterBar
            
            // 3. History List
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // Section: Today
                    historySection(date: "Today") {
                        // Dynamically filter content based on selection
                        if showItem(type: "Blood Pressure") {
                            VitalHistoryRow(icon: "heart.fill", iconColor: .red, title: "Blood Pressure", time: "09:41 AM", value: "118/76", unit: "mmHg", status: "Normal", statusColor: .green)
                        }
                        
                        if showItem(type: "Heart Rate") {
                            VitalHistoryRow(icon: "waveform.path.ecg", iconColor: .orange, title: "Heart Rate", time: "09:45 AM", value: "72", unit: "BPM", status: "Active", statusColor: .blue)
                        }
                    }
                    
                    // Section: Yesterday
                    historySection(date: "Yesterday, Oct 23") {
                        if showItem(type: "Weight") {
                            VitalHistoryRow(icon: "scalemass.fill", iconColor: .purple, title: "Weight", time: "08:30 AM", value: "165", unit: "lbs", status: "-2 lbs", statusColor: .green)
                        }
                    }
                    
                    // Section: Past
                    historySection(date: "Oct 20, 2023") {
                        if showItem(type: "Blood Pressure") {
                            VitalHistoryRow(icon: "heart.fill", iconColor: .red, title: "Blood Pressure", time: "10:00 AM", value: "130/85", unit: "mmHg", status: "High", statusColor: .orange)
                        }
                        
                        if showItem(type: "SpO2") {
                            VitalHistoryRow(icon: "drop.fill", iconColor: .cyan, title: "SpO2", time: "10:05 AM", value: "96", unit: "%", status: "Normal", statusColor: .green)
                        }
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarHidden(true)
    }
    
    // MARK: - Filter Logic
    private func showItem(type: String) -> Bool {
        return selectedFilter == "All" || selectedFilter == type
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
            Text("Vital History")
                .font(.headline)
                .bold()
            Spacer()
            Image(systemName: "chevron.left").font(.title3).opacity(0)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
    
    // 🟢 HIG COMPLIANT SCROLLABLE FILTERS
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    Button {
                        withAnimation(.snappy) {
                            selectedFilter = filter
                        }
                    } label: {
                        Text(filter)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedFilter == filter ? Color.blue : Color(uiColor: .systemBackground))
                            .foregroundStyle(selectedFilter == filter ? .white : .primary)
                            .clipShape(Capsule())
                            // Add a subtle border for unselected items to define the area
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    private func historySection<Content: View>(date: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.leading, 16)
            
            VStack(spacing: 0) {
                content()
            }
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            // Minimal layout, Grouped style doesn't need heavy shadow
        }
    }
}

// MARK: - Components

struct VitalHistoryRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let time: String
    let value: String
    let unit: String
    let status: String
    let statusColor: Color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                
                // Icon Box
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.body)
                        .foregroundStyle(iconColor)
                }
                
                // Info
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Values
                VStack(alignment: .trailing, spacing: 2) {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(value)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(uiColor: .label))
                        Text(unit)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Text(status)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(statusColor)
                }
            }
            .padding(16)
            
            // Custom Separator (simulating List separator)
            Divider().padding(.leading, 72)
        }
    }
}

#Preview {
    VitalHistoryView()
}
