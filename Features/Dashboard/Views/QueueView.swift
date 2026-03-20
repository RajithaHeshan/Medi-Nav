
import SwiftUI

struct QueueView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
      
                headerView
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        statusHeader
                        
                        mainTitleSection
                        
                        statsCard
                        
                        queueStepper
                        
                        locationTimeCard
                        
                        VStack(spacing: 12) {
                            QueueExpandableRow(icon: "person.3.fill", iconColor: .blue, title: "Queue Details", subtitle: "2 ahead • 5 total today")
                            QueueExpandableRow(icon: "doc.text.fill", iconColor: .purple, title: "Appointment Info", subtitle: "Follow-up • Dr. Sarah Chen")
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true) // We are using the custom header now
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
            
            Text("Latest Queue")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
                .padding(.trailing, 40) // Centers title by offsetting the back button width
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }
    
    private var statusHeader: some View {
        HStack {
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Text("Queue Active")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.green)
            }
            
            Spacer()
            
            Text("C-103")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.blue)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .clipShape(Capsule())
        }
    }
    
    private var mainTitleSection: some View {
        VStack(spacing: 8) {
            Text("OPD-10")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(Color(uiColor: .label))
            
            Text("General Medicine • Dr. Chen")
                .font(.headline)
                .foregroundStyle(Color.primary.opacity(0.75))
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
                        .fontWeight(.semibold)
                    Text("Est. Call")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primary.opacity(0.75))
                }
                Text("10:45 AM")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("~12 min wait")
                    .font(.subheadline)
                    .foregroundStyle(Color.primary.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            
      
            Divider()
                .frame(height: 60)
            
            
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(Color.blue)
                    Text("Speed")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primary.opacity(0.75))
                }
                Text("4 min")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(uiColor: .label))
                Text("per patient")
                    .font(.subheadline)
                    .foregroundStyle(Color.primary.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 24)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.gray.opacity(0.15), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 6)
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
   
            VStack(spacing: 12) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.1)).frame(width: 48, height: 48)
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(Color.blue).font(.title3.bold())
                }
                VStack(spacing: 4) {
                    Text("Location")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary.opacity(0.75))
                    Text("Room 204")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                }
            }
            .frame(maxWidth: .infinity)
            
         
            Divider()
                .frame(height: 60)
            
         
            VStack(spacing: 12) {
                ZStack {
                    Circle().fill(Color.purple.opacity(0.1)).frame(width: 48, height: 48)
                    Image(systemName: "calendar").foregroundStyle(Color.purple).font(.title3.bold())
                }
                VStack(spacing: 4) {
                    Text("Time")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primary.opacity(0.75))
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
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.gray.opacity(0.15), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 6)
    }
}

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
                        .stroke(Color(uiColor: .systemGray3), lineWidth: 2.0)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Color(uiColor: .systemBackground)))
                    
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color(uiColor: .systemGray))
                        .font(.body.weight(.bold))
                } else {
                    Circle()
                        .stroke(Color(uiColor: .systemGray3), lineWidth: 2.0)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(Color(uiColor: .systemBackground)))
                    
                    Text(mainText)
                        .font(.headline)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
            }
            .frame(height: 64)
            
         
            Text(subText.isEmpty ? " " : subText)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.primary.opacity(0.65))
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
        
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle().fill(iconColor.opacity(0.1)).frame(width: 44, height: 44)
                    Image(systemName: icon).foregroundStyle(iconColor).font(.body.bold())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color.primary.opacity(0.75))
                }
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.body.bold())
                    .foregroundStyle(Color(uiColor: .systemGray2))
            }
            .padding(16)
            .background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.15), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.03), radius: 8, x: 0, y: 3)
        }
    }
}

#Preview {
    NavigationStack {
        QueueView()
    }
}
