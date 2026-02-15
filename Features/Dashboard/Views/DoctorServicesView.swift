import SwiftUI
import Combine


struct ServiceHeroItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let buttonText: String
    let icon: String
}

struct DoctorServicesView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State private var showFindDoctor = false
    
   
    @State private var currentPage = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
   
    private let heroCards = [
        ServiceHeroItem(title: "Please Book Your Doctor", subtitle: "Schedule a Visit With our top Specialist", buttonText: "Book Now", icon: "person.3.fill"),
        ServiceHeroItem(title: "Please view Doctor booking history", subtitle: "View all the doctor booking history", buttonText: "View Now", icon: "clock.arrow.circlepath"),
        ServiceHeroItem(title: "Please meet your doctor", subtitle: "Meet doctor and get consulting and prescription", buttonText: "Get Consulting", icon: "stethoscope"),
        ServiceHeroItem(title: "View your consulting record", subtitle: "Check all the past records", buttonText: "View Consulting History", icon: "list.clipboard.fill")
    ]
    
    private let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                
                VStack(spacing: 24) {
                    headerSection
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            
                            Text("Welcome back! Choose a service to proceed with your medical consultation.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)
                            
                            // Carousel
                            TabView(selection: $currentPage) {
                                ForEach(0..<heroCards.count, id: \.self) { index in
                                    ServiceHeroCard(card: heroCards[index])
                                        .padding(.horizontal)
                                        .tag(index)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(height: 240)
                            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                            .onAppear {
                                UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
                                UIPageControl.appearance().pageIndicatorTintColor = .systemGray4
                            }
                            .onReceive(timer) { _ in
                                withAnimation(.spring()) {
                                    currentPage = (currentPage + 1) % heroCards.count
                                }
                            }
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                
                                
                                ServiceGridItem(title: "Doctors", icon: "person.3.fill", color: .blue) {
                                    showFindDoctor = true
                                }
                                
                              
                                ServiceGridItem(title: "Booking History", icon: "clock.arrow.circlepath", color: .orange) {
                                    print("Booking History Tapped")
                                }
                                ServiceGridItem(title: "Doctor Consulting", icon: "stethoscope", color: .teal) {
                                    print("Consulting Tapped")
                                }
                                ServiceGridItem(title: "Consulting History", icon: "list.clipboard.fill", color: .purple) {
                                    print("History Tapped")
                                }
                            }
                            
                            Spacer(minLength: 40)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
            
            .navigationDestination(isPresented: $showFindDoctor) {
                FindDoctorView()
                    .navigationBarBackButtonHidden(true) // We use our custom back button
            }
        }
    }
    
    private var headerSection: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.left")
                    .font(.title3).bold().foregroundStyle(Color(uiColor: .label))
                    .padding(10).background(Color(uiColor: .systemBackground))
                    .clipShape(Circle()).shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
            }
            Text("Doctor Services").font(.title3).bold().frame(maxWidth: .infinity, alignment: .center).padding(.trailing, 40)
        }
        .padding(.horizontal).padding(.top, 10)
    }
}



struct ServiceHeroCard: View {
    let card: ServiceHeroItem
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                Text(card.title).font(.title3).bold().foregroundStyle(.white).fixedSize(horizontal: false, vertical: true)
                Text(card.subtitle).font(.caption).foregroundStyle(.white.opacity(0.9)).fixedSize(horizontal: false, vertical: true).lineLimit(2)
                Button { print("Tapped: \(card.buttonText)") } label: {
                    Text(card.buttonText).font(.subheadline).fontWeight(.semibold).foregroundStyle(.teal)
                        .padding(.horizontal, 24).padding(.vertical, 10).background(Color.white).clipShape(Capsule())
                }.padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.2)).frame(width: 90, height: 90)
                Image(systemName: card.icon).font(.system(size: 36)).foregroundStyle(.white)
            }
        }
        .padding(24)
        .background(LinearGradient(colors: [Color.teal, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}


struct ServiceGridItem: View {
    let title: String
    let icon: String
    let color: Color
  
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 16) {
                ZStack {
                    Circle().fill(color.opacity(0.1)).frame(width: 70, height: 70)
                    Image(systemName: icon).font(.title).foregroundStyle(color)
                }
                Text(title).font(.subheadline).fontWeight(.semibold).foregroundStyle(Color(uiColor: .label)).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity).padding(.vertical, 24).background(Color(uiColor: .systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20)).shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DoctorServicesView()
    CustomTabBar(selectedTab: .constant(.home))
}


