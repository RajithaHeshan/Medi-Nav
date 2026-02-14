import SwiftUI

struct GridCard: View {
    let option: MenuOption
    
    var body: some View {
        VStack {
            
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.05))
                    .frame(width: 50, height: 50)
                
                Image(systemName: option.systemIcon)
                    .font(.title2)
                    .foregroundStyle(.blue)
            }
            .frame(height: 60)
            
            Text(option.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        // HIG Shadow: Soft and subtle
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

