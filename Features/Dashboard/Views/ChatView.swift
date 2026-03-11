import SwiftUI


struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let timestamp: String
    let isCurrentUser: Bool
    let isRead: Bool
}

struct ChatView: View {
    @Environment(\.dismiss) var dismiss
    @State private var messageText = ""
    
  
    @State private var messages = [
        ChatMessage(text: "Hello S.G.I.K., I've reviewed your latest lab reports. I'm prescribing Amoxicillin for the next 10 days.", timestamp: "10:24 AM", isCurrentUser: false, isRead: false),
        ChatMessage(text: "Thank you, Dr. Wilson. Should I take it with food?", timestamp: "10:25 AM", isCurrentUser: true, isRead: true),
        ChatMessage(text: "Yes, please take 1 tablet every 12 hours after food.", timestamp: "10:26 AM", isCurrentUser: false, isRead: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
          
            headerView
            
           
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                       
                        Text("Today")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(uiColor: .secondaryLabel))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Color(uiColor: .systemGray6))
                            .clipShape(Capsule())
                            .padding(.top, 16)
                        
                      
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
                .background(Color(uiColor: .systemBackground))
                .onAppear {
                  
                    if let lastMessage = messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            
            
            inputBar
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
            
            HStack(spacing: 12) {
              
                ZStack(alignment: .topLeading) {
                    Image("doctor1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                    
                    Circle()
                        .fill(Color.green)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 2))
                        .offset(x: -2, y: 2)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Dr. Sarah Wilson")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(uiColor: .label))
                    
                    Text("Cardiologist")
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
        .background(Color(uiColor: .systemBackground))
        .shadow(color: Color.black.opacity(0.03), radius: 5, y: 4)
        .zIndex(1)
    }
    
    private var inputBar: some View {
        HStack(spacing: 12) {
           
            Button(action: {}) {
                Image(systemName: "plus")
                    .font(.title2.weight(.medium))
                    .foregroundStyle(Color(uiColor: .systemGray2))
                    .frame(width: 40, height: 40)
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.05), radius: 3, y: 2)
            }
            
      
            TextField("Type a message...", text: $messageText)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(uiColor: .systemBackground))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.05), radius: 3, y: 2)
            
           
            Button(action: {
                if !messageText.isEmpty {
                  
                    let newMessage = ChatMessage(text: messageText, timestamp: "Now", isCurrentUser: true, isRead: false)
                    messages.append(newMessage)
                    messageText = ""
                }
            }) {
                Image(systemName: messageText.isEmpty ? "mic.fill" : "paperplane.fill")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, y: 3)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
    }
}


struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            
            // Incoming Avatar
            if !message.isCurrentUser {
                Image("doctor1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
            } else {
                Spacer()
            }
            
           
            VStack(alignment: message.isCurrentUser ? .trailing : .leading, spacing: 6) {
                Text(message.text)
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(message.isCurrentUser ? Color.blue : Color(uiColor: .systemGray6))
                    .foregroundStyle(message.isCurrentUser ? Color.white : Color(uiColor: .label))
                    // HIG iOS 17+ Modern Corner Radii (Sharper corner at the tail)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: message.isCurrentUser ? 20 : 4,
                            bottomTrailingRadius: message.isCurrentUser ? 4 : 20,
                            topTrailingRadius: 20
                        )
                    )
                
               
                HStack(spacing: 4) {
                    Text(message.timestamp)
                        .font(.caption2)
                        .foregroundStyle(Color(uiColor: .tertiaryLabel))
                    
                    if message.isCurrentUser {
                        Image(systemName: "checkmark.circle.fill") // or "checkmark.circle"
                            .font(.system(size: 10))
                            .foregroundStyle(message.isRead ? Color.blue : Color.gray)
                    }
                }
                .padding(.horizontal, 4)
            }
            
            if message.isCurrentUser {
                Image("user1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .background(Circle().fill(Color.orange.opacity(0.2)))
            } else {
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatView()
    }
}
