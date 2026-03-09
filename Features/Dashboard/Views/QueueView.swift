
import SwiftUI

struct QueueView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // HIG Background Color: Light gray on light mode, dark gray on dark mode
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    // 1. Status Pill Header
                    statusHeader
                    
                    // 2. Main Title Section
                    mainTitleSection
                    
                    // 3. Stats Card (Est. Call & Speed)
                    statsCard
                    
                    // 4. Visual Queue Stepper
                    queueStepper
                    
                    // 5. Location & Time Card
                    locationTimeCard
                    
                    // 6. Expandable Info Rows
                    VStack(spacing: 12) {
                        QueueExpandableRow(icon: "person.3.fill", iconColor: .blue, title: "Queue Details", subtitle: "2 ahead • 5 total today")
                        QueueExpandableRow(icon: "doc.text.fill", iconColor: .purple, title: "Appointment Info", subtitle: "Follow-up • Dr. Sarah Chen")
                    }
                    
                    // HIG Fix: Keep content above the CustomTabBar
                    Spacer(minLength: 120)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        .navigationTitle("Latest Queue")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "arrow.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color.blue)
                }
            }
        }
    }
    
    // MARK: - View Components
    
    private var statusHeader: some View {
        HStack {
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Queue Active")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.green)
            }
            
            Spacer()
            
            Text("C-103")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.blue.opacity(0.1))
                .clipShape(Capsule())
        }
    }
    
    private var mainTitleSection: some View {
        VStack(spacing: 8) {
            Text("OPD-10")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(Color(uiColor: .label))
            
            Text("General Medicine • Dr. Chen")
                .font(.headline)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
        .padding(.vertical, 8)
    }
    
    private var statsCard: some View {
        HStack(spacing: 0) {
            // Left Column
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.blue)
                    Text("Est. Call")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                Text("10:45 AM")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("~12 min wait")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            .frame(maxWidth: .infinity)
            
            // Vertical Divider
            Divider()
                .frame(height: 60)
            
            // Right Column
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(Color.blue)
                    Text("Speed")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                Text("4 min")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("per patient")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 24)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.gray.opacity(0.1), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 4)
    }
    
    private var queueStepper: some View {
        HStack(spacing: 16) {
            QueueStepView(state: .past, mainText: "", subText: "C-08")
            QueueStepView(state: .past, mainText: "", subText: "C-09")
            QueueStepView(state: .active, mainText: "10", subText: "")
            QueueStepView(state: .future, mainText: "11", subText: "C-11")
            QueueStepView(state: .future, mainText: "12", subText: "C-12")
        }
        .padding(.vertical, 16)
    }
    
    private var locationTimeCard: some View {
        HStack(spacing: 0) {
            // Location Column
            VStack(spacing: 12) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.1)).frame(width: 44, height: 44)
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).font(.title3)
                }
                VStack(spacing: 4) {
                    Text("Location")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("Room 204")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            .frame(maxWidth: .infinity)
            
            // Vertical Divider
            Divider()
                .frame(height: 60)
            
            // Time Column
            VStack(spacing: 12) {
                ZStack {
                    Circle().fill(Color.purple.opacity(0.1)).frame(width: 44, height: 44)
                    Image(systemName: "calendar").foregroundStyle(Color.purple).font(.title3)
                }
                VStack(spacing: 4) {
                    Text("Time")
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                    Text("10.30 AM")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 24)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.gray.opacity(0.1), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Reusable Subcomponents

struct QueueStepView: View {
    enum StepState {
        case past, active, future
    }
    
    let state: StepState
    let mainText: String
    let subText: String
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                if state == .active {
                    // Soft glow background for active step
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 64, height: 64)
                    
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 48, height: 48)
                    
                    Text(mainText)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                } else if state == .past {
                    Circle()
                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1.5)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Color(uiColor: .systemBackground)))
                    
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .font(.body.weight(.bold))
                } else {
                    Circle()
                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1.5)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Color(uiColor: .systemBackground)))
                    
                    Text(mainText)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .systemGray2))
                }
            }
            .frame(height: 64) // Fixed height to keep alignment even when active is larger
            
            // Subtext Label
            Text(subText.isEmpty ? " " : subText) // Keep space to prevent jumping
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
        }
    }
}

struct QueueExpandableRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        Button {
            // Future logic to expand or navigate
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(iconColor.opacity(0.1)).frame(width: 40, height: 40)
                    Image(systemName: icon).foregroundStyle(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .systemGray3))
            }
            .padding(16)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.1), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    NavigationStack {
        QueueView()
    }
}
