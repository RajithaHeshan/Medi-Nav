
import SwiftUI

struct TimelineRow: View {
    let step: VisitStep
    let isLast: Bool
    
    //Colors for status
    private var statusColor: Color {
        switch step.status {
        case .completed: return .teal
        case .current: return .green
        case .pending: return .gray
        }
    }
    
    private var iconName: String {
        switch step.status {
        case .completed: return "checkmark"
        case .current: return "stethoscope"
        case .pending: return "flask"
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // 1. Vertical Line & Icon Column
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(statusColor.opacity(0.15))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(statusColor)
                }
                
                // Draw connecting line if not last item
                if !isLast {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 2)
                        .frame(minHeight: 40) // Allows dynamic expansion
                }
            }
            
            // 2. Text Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(step.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    if let time = step.time {
                        Text(time)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
                
                if let subtitle = step.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(step.status == .current ? .green : .secondary)
                }
            }
            .padding(.bottom, isLast ? 0 : 24)
        }
    }
}
