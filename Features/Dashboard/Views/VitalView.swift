import SwiftUI

struct VitalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
              
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
              
                        searchBar
                        
                
                        nurseProfileCard
                        
                      
                        queueCard
                        
                      
                        actionCard
                        
                   
                        vitalsSection
                        
                       
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
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
            
            Text("Vital")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
            
            TextField("Search doctors...", text: $searchText)
            
            Spacer()
            
            Image(systemName: "mic.fill")
                .foregroundStyle(Color(uiColor: .systemGray2))
                .font(.body.weight(.medium))
        }
        .padding(12)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var nurseProfileCard: some View {
        HStack(spacing: 16) {
            Image("doctor1")
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.1), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Nurse Sarah Jenk")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("General Practitioner")
                    .font(.subheadline)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Text("Visit Date: Oct 24, 2023")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundStyle(Color(uiColor: .systemGray3))
        }
        .padding(16)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    
    private var queueCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Visit Nurse")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill").foregroundStyle(Color.blue).frame(width: 20)
                    Text("Ms. Wickrama (Chief Nurse)").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
          
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "person.2.fill").foregroundStyle(Color.blue)
                    Text("05 Queue").font(.subheadline).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                
                Divider().frame(height: 24)
                
                HStack(spacing: 8) {
                    Image(systemName: "hourglass").foregroundStyle(Color.orange)
                    Text("15 mins").font(.subheadline).fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 14)
            .background(Color(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button(action: { }) {
                    HStack(spacing: 4) {
                        Text("View Map")
                        Image(systemName: "arrow.right")
                    }
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.blue)
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    

    private var actionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Next Step: Visit Doctor")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "person.fill").foregroundStyle(Color.blue).frame(width: 20)
                    Text("DR. Wickrama").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).frame(width: 20)
                    Text("2nd Floor, West Wing").font(.subheadline).foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            Button {
               
            } label: {
                Text("Check in to consultation")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.top, 4)
            
            HStack {
                Text("Please proceed immediately")
                    .font(.caption)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
                Spacer()
                Button(action: { }) {
                    Text("View Map")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.blue)
                        .padding(.vertical, 8)
                        .contentShape(Rectangle())
                }
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
    
    private var vitalsSection: some View {
        VStack(spacing: 16) {
            VitalMeasurementCard(
                icon: "heart.text.square.fill", iconColor: .red, title: "Blood Pressure", badgeText: "Normal", badgeColor: .green, value: "118/76", unit: "mmHg",
                graphLineColor: .blue.opacity(0.6), graphPoints: [0.3, 0.5, 0.4, 0.8, 0.4, 0.2, 0.3, 0.2]
            )
            
            VitalMeasurementCard(
                icon: "scalemass.fill", iconColor: .purple, title: "Weight", badgeText: "-2 lbs", badgeColor: .green, value: "165", unit: "lbs",
                graphLineColor: .purple.opacity(0.6), graphPoints: [0.2, 0.4, 0.3, 0.7, 0.5, 0.4, 0.2, 0.3]
            )
            
            VitalMeasurementCard(
                icon: "thermometer.medium", iconColor: .teal, title: "Body Temp", badgeText: nil, badgeColor: .clear, value: "98.6", unit: "°F",
                graphLineColor: .teal.opacity(0.6), graphPoints: [0.2, 0.6, 0.5, 0.8, 0.4, 0.3, 0.5, 0.4]
            )
        }
    }
}


struct VitalMeasurementCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let badgeText: String?
    let badgeColor: Color
    let value: String
    let unit: String
    let graphLineColor: Color
    let graphPoints: [CGFloat]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
        
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundStyle(iconColor)
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                Spacer()
                
                if let badge = badgeText {
                    Text(badge)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(badgeColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(badgeColor.opacity(0.15))
                        .clipShape(Capsule())
                }
            }
            
          
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Color(uiColor: .label))
                Text(unit)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            
         
            ZStack {
             
                SmoothLineGraph(points: graphPoints.reversed()) 
                    .stroke(Color.green.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                
        
                SmoothLineGraph(points: graphPoints)
                    .stroke(graphLineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
            .frame(height: 50)
            .padding(.top, 10)
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
    }
}


struct SmoothLineGraph: Shape {
    var points: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard points.count > 1 else { return path }
        
        let stepX = rect.width / CGFloat(points.count - 1)
        
       
        var currentPoint = CGPoint(x: 0, y: rect.height - (points[0] * rect.height))
        path.move(to: currentPoint)
        
      
        for i in 1..<points.count {
            let nextPoint = CGPoint(x: CGFloat(i) * stepX, y: rect.height - (points[i] * rect.height))
            let control1 = CGPoint(x: currentPoint.x + (nextPoint.x - currentPoint.x) / 2, y: currentPoint.y)
            let control2 = CGPoint(x: currentPoint.x + (nextPoint.x - currentPoint.x) / 2, y: nextPoint.y)
            
            path.addCurve(to: nextPoint, control1: control1, control2: control2)
            currentPoint = nextPoint
        }
        return path
    }
}

#Preview {
    NavigationStack {
        VitalView()
    }
}
