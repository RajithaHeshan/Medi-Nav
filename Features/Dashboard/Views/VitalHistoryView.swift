
import SwiftUI

struct VitalHistoryView: View {
    @Environment(\.dismiss) var dismiss
    
   
    @State private var selectedFilter = "All"
    
  
    let filters = ["All", "Blood Pressure", "Heart Rate", "Weight", "SpO2", "Body Temp"]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
               
                VStack(spacing: 12) {
                    headerView
                    filterBar
                }
                .padding(.bottom, 12)
                .background(Color(uiColor: .systemGroupedBackground))
                .zIndex(1)
                
               
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                       
                        historySection(date: "Today") {
                            if showItem(type: "Blood Pressure") {
                                VitalHistoryRow(
                                    icon: "heart.fill", iconColor: .red, title: "Blood Pressure", time: "09:41 AM", value: "118/76", unit: "mmHg", status: "Normal", statusColor: .green,
                                    showDivider: showItem(type: "Heart Rate")
                                )
                            }
                            
                            if showItem(type: "Heart Rate") {
                                VitalHistoryRow(
                                    icon: "waveform.path.ecg", iconColor: .orange, title: "Heart Rate", time: "09:45 AM", value: "72", unit: "BPM", status: "Active", statusColor: .blue,
                                    showDivider: false // Last item in block
                                )
                            }
                        }
                        
                        // Section: Yesterday
                        historySection(date: "Yesterday, Oct 23") {
                            if showItem(type: "Weight") {
                                VitalHistoryRow(
                                    icon: "scalemass.fill", iconColor: .purple, title: "Weight", time: "08:30 AM", value: "165", unit: "lbs", status: "-2 lbs", statusColor: .green,
                                    showDivider: false
                                )
                            }
                        }
                        
                        // Section: Past
                        historySection(date: "Oct 20, 2023") {
                            if showItem(type: "Blood Pressure") {
                                VitalHistoryRow(
                                    icon: "heart.fill", iconColor: .red, title: "Blood Pressure", time: "10:00 AM", value: "130/85", unit: "mmHg", status: "High", statusColor: .orange,
                                    showDivider: showItem(type: "SpO2")
                                )
                            }
                            
                            if showItem(type: "SpO2") {
                                VitalHistoryRow(
                                    icon: "drop.fill", iconColor: .cyan, title: "SpO2", time: "10:05 AM", value: "96", unit: "%", status: "Normal", statusColor: .green,
                                    showDivider: false
                                )
                            }
                        }
                        
                       
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                }
            }
        }
        .navigationBarHidden(true)
    }
    

    private func showItem(type: String) -> Bool {
        return selectedFilter == "All" || selectedFilter == type
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
            
            Spacer()
            
            Text("Vital History")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40) 
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
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
                            .fontWeight(.bold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(selectedFilter == filter ? Color.blue : Color(uiColor: .systemBackground))
                            .foregroundStyle(selectedFilter == filter ? .white : Color(uiColor: .label))
                            .clipShape(Capsule())
                            .shadow(color: selectedFilter == filter ? Color.blue.opacity(0.3) : Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 4)
        }
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
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
        }
    }
}



struct VitalHistoryRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let time: String
    let value: String
    let unit: String
    let status: String
    let statusColor: Color
    var showDivider: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                
              
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: icon)
                        .font(.body)
                        .foregroundStyle(iconColor)
                }
                
               
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text(time)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // Values
                VStack(alignment: .trailing, spacing: 4) {
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
            
        
            if showDivider {
                Divider().padding(.leading, 76)
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        VitalHistoryView()
    }
}
