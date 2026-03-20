import SwiftUI

struct DisplayAndTextSizeView: View {
    @Environment(\.dismiss) var dismiss
    
  
    @AppStorage("isBoldTextEnabled") private var isBoldTextEnabled = false
    @AppStorage("appTextSize") private var textSize: Double = 60.0 // 60 maps to Apple's default .large
    
    @State private var isButtonShapesEnabled = false
    @State private var isOnOffLabelsEnabled = false
    
    @State private var isReduceTransparencyEnabled = false
    @State private var isIncreaseContrastEnabled = false

   
    private var currentDynamicTypeSize: DynamicTypeSize {
        switch textSize {
        case 0..<20: return .xSmall
        case 20..<40: return .small
        case 40..<60: return .medium
        case 60..<80: return .large
        case 80..<100: return .xLarge
        default: return .xxLarge
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                      
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(spacing: 0) {
                                SimpleToggleRow(title: "Bold Text", isOn: $isBoldTextEnabled, showDivider: true)
                                
                           
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Text Size")
                                        .font(.subheadline)
                                        .foregroundStyle(Color(uiColor: .label))
                                    
                                    HStack(spacing: 16) {
                                        Image(systemName: "textformat.size.smaller")
                                            .font(.system(size: 14))
                                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                                        
                                        Slider(value: $textSize, in: 0...100, step: 20)
                                            .tint(.blue)
                                        
                                        Image(systemName: "textformat.size.larger")
                                            .font(.system(size: 20))
                                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                        // 2. Button Options
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(spacing: 0) {
                                SimpleToggleRow(title: "Button Shapes", isOn: $isButtonShapesEnabled, showDivider: true)
                                SimpleToggleRow(title: "On/Off Labels", isOn: $isOnOffLabelsEnabled, showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            VStack(spacing: 0) {
                                SimpleToggleRow(title: "Reduce Transparency", isOn: $isReduceTransparencyEnabled, showDivider: true)
                                SimpleToggleRow(title: "Increase Contrast", isOn: $isIncreaseContrastEnabled, showDivider: false)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 2)
                            
                            Text("Increase Contrast improves color contrast between app foreground and background colors.")
                                .font(.footnote)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .padding(.horizontal, 16)
                                .padding(.top, 4)
                        }
                        
                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
       
        .environment(\.dynamicTypeSize, currentDynamicTypeSize)
        .environment(\.legibilityWeight, isBoldTextEnabled ? .bold : .regular)
    }
    
    // MARK: - Subviews
    
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
            
            Text("Display & Text Size")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
}


struct SimpleToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    var showDivider: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.body) 
                    .foregroundStyle(Color(uiColor: .label))
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            
            if showDivider {
                Divider()
                    .padding(.leading, 16)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isOn.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayAndTextSizeView()
    }
}


