//
//  Dashboard View.swift
//  Ahead
//
//  Created by Henry MacLane on 9/30/24.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @State private var currentPage: String = "Dashboard" // State variable to track the current page

    var body: some View {
        VStack {
            // Sticky Header
            
                HeaderView(currentPage: $currentPage)
                    Spacer()
            
            // Conditional view rendering based on currentPage
            if currentPage == "Dashboard" {
                ScrollView {
                    VStack(spacing: 20) {
                        BalanceView()
                            .padding(.top, 20)
                            .padding(.horizontal, -20)
                        CreditAndSavings(currentPage: $currentPage)
                 //       DailyTask()
                        InviteFriend()
                        RecentTransactionsView()
                        BottomInfoView()
                    // InvestmentsOverviewView()  add this after first app stage is released
                    }
                    .padding(.bottom, 40) // Padding for the bottom of the scroll view
                }
            }  else if currentPage == "Learn" {
                Learn()
            } else if currentPage == "Credit" {
                Credit()
            } else if currentPage == "Wallet" {
                Wallet()
            } else if currentPage == "Settings" {
                Settings()
            } else {
                Text("Unknown Page") // Fallback for unknown pages
            }

            FooterNavigationView(currentPage: $currentPage)
                .background(Color(.systemGray6)) // Set footer background to slightly gray
                .padding(.bottom, -25) // Keep it at the bottom
                .frame(maxWidth: .infinity) // Full width for the footer
        }
        .background(Color.black) // Set page background to slightly gray
        .edgesIgnoringSafeArea(.top) // Ignore safe area for the header
        .navigationBarBackButtonHidden(true)
    }
}


struct HeaderView: View {
    @Binding var currentPage: String
    
    var body: some View {
        HStack {
            // Person icon navigation to Settings
            Button(action: {
                currentPage = "Settings"
            }) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }

            // User greeting
            Text("Hi, Henry")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
           // Bell icon navigation to Dashboard
            NavigationLink(destination: Notifications()) {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 21, height: 21)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
           
        }
        .padding(.top, 60)
        .padding(.bottom, 10)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.black)
        .zIndex(1) // Keep the header above other content
    }
}




struct BalanceView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                
                // Account Balance
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        Text("Account Balance")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("$89.92")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    
                    // Buttons for Add, Send, Request
                    HStack {
                        Spacer()
                        NavigationLink(destination: Deposit()) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color("MainColor")) // Fill with MainColor
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "plus")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                }
                                Text("Deposit")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: Deposit()) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color("MainColor")) // Fill with MainColor
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "creditcard")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                }
                                Text("Withdraw")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: QR()) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color("MainColor")) // Fill with MainColor
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "dollarsign")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                }
                                Text("Request")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: QR()) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color("MainColor")) // Fill with MainColor
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "paperplane")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                }
                                Text("Send")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                .padding()
            }
            .background(Color("BLACK2"))
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("MainColor"), lineWidth: 0))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 20)
        .background(Color.black)
    }
}





struct CreditAndSavings: View {
    @Binding var currentPage: String
    @State private var creditScoreChange: Int = 0
    @State private var creditScore: Int = 732
    @State private var amtSavingsGoals: String = "2"
    @State private var savingsGoalAmt: String = "500"

    var creditScoreColor: Color {
        switch creditScore {
        case 800...850:
            return .green
        case 740..<800:
            return .green
        case 670..<740:
            return .yellow
        case 580..<670:
            return .orange
        default:
            return .red
        }
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 20) { // Adjust the spacing here for the middle gap
                // Savings Goals Button
                NavigationLink(destination: SavingsDashboardView()) {
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color("BLACK3"))
                                    .frame(width: 75, height: 17)

                                Text("\(amtSavingsGoals) Goals")
                                    .scaledToFit()
                                    .font(.caption)
                                    .foregroundStyle(Color.white)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 10)
                                .foregroundStyle(Color.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.leading, -60)
                        .padding(.top)

                        Image("piggy")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .padding(.bottom, 5)
                        Text("Savings Goals")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text("$500")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.bottom)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.42, height: 150) // Increase width to 43% of screen width
                    .background(Color("BLACK2"))
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("MainColor"), lineWidth: 0)) // Outline in black
                }

                // Credit Score Button with a Button instead of NavigationLink
                Button(action: {
                    currentPage = "Credit"
                }) {

                    VStack(spacing: 10) {
                        HStack {
                            Text("Credit Builder")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(height: 10)
                        }
                        .padding(.bottom, 10)

                        ZStack {
                            let smallCircleRadius: CGFloat = 5
                            let smallCircleOffset: CGFloat = 55

                            
                            Circle()
                                .fill(Color("MainColor"))
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: -smallCircleOffset - smallCircleRadius, y: 27)

                            Circle()
                                .fill(Color(.systemGray5))
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: 60, y: 28)
                            
                            Circle()
                                .fill(Color("MainColor"))
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: 60, y: 24)
                        
                            
                            HalfCircleIndicator(score: creditScore)
                                .stroke(Color("MainColor"), lineWidth: 10)
                                .frame(width: 120, height: 55)
                                .offset(y: -1)

                            Text("\(creditScore)")
                                .font(.title2)
                                .foregroundStyle(Color.white)
                                .fontWeight(.bold)
                        }

                        HStack(spacing: 1) {
                            if creditScoreChange < 0 {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundColor(.red)
                                    .scaleEffect(0.5)
                                    .padding(.top, -22)
                                Text("\(creditScoreChange)")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.top, -22)
                            } else if creditScoreChange == 0 {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.gray)
                                    .scaleEffect(0.5)
                                    .padding(.top, -22)
                                Text("\(creditScoreChange)")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                                    .padding(.top, -22)
                            } else {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundColor(.green)
                                    .scaleEffect(0.5)
                                    .padding(.top, -22)
                                Text("\(creditScoreChange)")
                                    .foregroundColor(.green)
                                    .font(.caption)
                                    .padding(.top, -22)
                            }
                        }

                        Text("Excellent")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.42, height: 150) // Increase width to 43% of screen width
                    .background(Color("BLACK2"))
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("MainColor"), lineWidth: 0)) // Outline in black
                }
            }
            .padding(.horizontal, geometry.size.width * 0.055) // Increase padding for equal spacing on both sides
        }
        .frame(height: 150) // Set height for GeometryReader content
        
    }
}




struct HalfCircleIndicator: Shape {
    var score: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerX = rect.midX
        let centerY = rect.maxY // Positioned at the bottom
        let radius = rect.width / 2

        // Define the start and end angles for the arc
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 180)

        // Draw the half-circle arc
        path.addArc(center: CGPoint(x: centerX, y: centerY),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)

        return path
    }
}









struct DailyTask: View {
    var body: some View {
        NavigationLink(destination: Wallet()) {
            HStack {
                // Card Icon
                Image(systemName: "message.badge.circle.fill") // Replace with your custom image if needed
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color("MainColor"))
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.trailing, 8)
                
                // Title and Subtitle
                VStack(alignment: .leading) {
                    Text("Complete Sign Up")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("Ask an adult for help")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}





            

/*
struct PeriodButton: View {
    var title: String
    @Binding var selectedPeriod: String?

    var body: some View {
        Button(action: {
            selectedPeriod = title
        }) {
            Text(title)
                .font(.body)
                .padding(5)
                .background(selectedPeriod == title ? Color("MainColor") : Color(.systemGray6))
                .foregroundColor(selectedPeriod == title ? Color.white : Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 0)
                )
        }
        .frame(width: 55.0, height: 10.0)
        .buttonStyle(PlainButtonStyle())
    }
}

struct InvestmentsOverviewView: View {
    @State private var selectedPeriod: String? = "1D" // Set default to "1D"
    @State private var selectedValue: Double? = nil // Set to nil for no initial selection
    let data: [Double] = Array(repeating: 0.0, count: 0) // Set the data to 0 zeros

    var body: some View {
        VStack(alignment: .center) { // Change alignment to center
            Text("Investments Overview")
                .font(.headline)

            // Display total amount and percentage
            VStack(alignment: .center) {
                Text("$\(selectedValue?.formatted() ?? "0.00")") // Use the selected value
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)

                // Add percentage text beneath the balance
                Text("+0.00 (0%)") // This can be dynamically updated later
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)

            Chart {
                ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                    LineMark(
                        x: .value("X", index),
                        y: .value("Y", value)
                    )
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                }

                // Add a blue horizontal line at $0
                RuleMark(y: .value("Y", 0))
                    .foregroundStyle(Color.blue) // Change to your desired color
                    .lineStyle(StrokeStyle(lineWidth: 2)) // Dashed line for clarity

                // Add a vertical line for the selected value, only visible during drag
                if let selected = selectedValue {
                    RuleMark(x: .value("X", selected)) // Change this if you need the index instead
                        .foregroundStyle(Color("MainColor")) // Customize line color
                        .lineStyle(StrokeStyle(lineWidth: 2)) // Line for selected value
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Safely unwrap the plotFrame
                                    if let plotFrame = proxy.plotFrame {
                                        let position = value.location.x - geometry[plotFrame].origin.x
                                        if let xValue: Double = proxy.value(atX: position) {
                                            selectedValue = xValue // Update selectedValue with the new value
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    // Reset selectedValue to nil when drag ends
                                    selectedValue = nil
                                }
                        )
                }
            }
            .frame(height: 300)
            .background(Color(.systemGray6)) // Set chart background to slightly gray
            // Remove axis marks completely
            .chartXAxis {
                AxisMarks() // No marks or lines for X-axis
            }
            .chartYAxis {
                AxisMarks() // No marks or lines for Y-axis
            }

            // Time selection buttons
            HStack {
                PeriodButton(title: "1D", selectedPeriod: $selectedPeriod)
                PeriodButton(title: "7D", selectedPeriod: $selectedPeriod)
                PeriodButton(title: "30D", selectedPeriod: $selectedPeriod)
                PeriodButton(title: "90D", selectedPeriod: $selectedPeriod)
                PeriodButton(title: "1Y", selectedPeriod: $selectedPeriod)
                PeriodButton(title: "ALL", selectedPeriod: $selectedPeriod)
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: InvestPageView()) {
                Text("See More")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundStyle(Color("MainColor"))
            }
            .padding()
        }
        .padding(.horizontal)
    }
}
*/

struct RecentTransactionsView: View {
    var body: some View {
        VStack {
            Divider()
                .background(Color.white)
        }
        NavigationLink(destination: Notifications()) {
            VStack(alignment: .center) {
                Text("Transactions")
                    .font(.title2)
                    .foregroundStyle(Color(.white))
                    .bold()
                    .padding(.bottom, 5)
                    .padding(.horizontal, 10)
                
                
                VStack(alignment: .center) {
                    Text("Transactions will be displayed here.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.vertical, 40)
                        .padding(.horizontal, 50)
                }
                .padding()
                
                VStack {
                    Divider()
                        .background(Color.gray)
                }
            }
        }
    }
}

struct InviteFriend: View {
    @State private var cardLastFour: String = "2734"
    @State private var dailyStreak = 0
    @State private var selectedIndex = 0

    var body: some View {
        VStack(spacing: 0) { // Set spacing to 0 to remove extra space
            VStack {
                Divider()
                    .background(Color.gray)
            }
            // TabView with content
            TabView(selection: $selectedIndex) {
                // First screen: Card Management
                NavigationLink(destination: Wallet()) {
                    HStack {
                        // Card Icon
                        Image(systemName: "creditcard.fill") // Replace with your custom image if needed
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color("MainColor"))
                            .background(Color.black)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                        
                        // Title and Subtitle
                        VStack(alignment: .leading) {
                            Text("Manage my card")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("*\(cardLastFour) card is unlocked.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        
                    }
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                .tag(0)
                
                // Second screen: Refer a Friend
                NavigationLink(destination: InviteFriendsView()) {
                    HStack {
                        Image(systemName: "person.2.badge.plus.fill") // Icon for referring a friend
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size: 40))
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading) {
                            Text("Refer a friend")
                                .font(.headline)
                                .foregroundColor(Color.white)
                            Text("Earn $5 for each friend you refer!")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .tag(1)
                
                // Third screen: Daily Trivia
                NavigationLink(destination: DailyTriviaView()) {
                    HStack {
                        Image(systemName: "questionmark.square.fill") // Icon for daily trivia
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Ensure the icon maintains its aspect ratio
                            .frame(height: 50) // Adjust the height as needed
                            .foregroundColor(Color("MainColor"))
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading) {
                            Text("Daily Trivia")
                                .font(.headline)
                                .foregroundColor(Color.white)
                            Text("Keep your streak going!")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                        Spacer() // Pushes content to the left
                        
                        HStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(dailyStreak == 0 ? .gray : .orange) // Set color based on dailyStreak
                            
                            
                            Text("\(dailyStreak)")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .tag(2)
                }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disables default dots
            .frame(height: 90) // Set a fixed height for the TabView to ensure visibility
            
            // Custom page control dots
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color("MainColor") : Color.white)
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                }
            }
            .padding(.vertical, 10) // Padding for dots section
            .padding(.top, -15)
            .padding(.bottom, -100)
        }
        .padding(.top, 0) // Padding above the top divider (adjust as needed)
        .padding(.bottom, 0) // Padding below the bottom divider (adjust as needed)
    }
}








struct BottomInfoView: View {
    var body: some View {
        VStack(spacing: 10) {
            // Shield Icon and FDIC-Insured Information
            VStack(spacing: 5) {
                Image(systemName: "checkmark.shield")
                    .font(.system(size: 40))
                    .foregroundColor(Color("MainColor"))
         
                    Text("Your balance is FDIC-insured through our partner bank, Example Bank and Trust, for up to $250,000 per person.")
                        .font(.system(size: 14))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
            }
            
            // Privacy Notice, Terms of Service
            VStack(spacing: 5) {
                        HStack {
                            Link(destination: URL(string: "https://example.com/privacy")!) {
                                Text("Privacy Policy")
                                    .underline()
                                    .foregroundColor(Color.white)
                            }

                            Link(destination: URL(string: "https://example.com/terms")!) {
                                Text("Terms of Service")
                                    .underline()
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .font(.system(size: 14))
                    .padding(.bottom, 1)
            
            // Social Media Icons
            HStack(spacing: 20) {
                Link(destination: URL(string: "https://example.com")!) {
                    Image("Insta")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                Link(destination: URL(string: "https://example.com")!) {
                    Image("TikTok")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                Link(destination: URL(string: "https://example.com")!) {
                    Image("YT")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
            }
            .font(.system(size: 30))
            .foregroundColor(.black)
            .padding()
            
            // Version
            Text("Version 1.01")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.bottom, -30)
    }
}

struct FooterNavigationView: View {
    @Binding var currentPage: String // Bind the current page to navigate

    var body: some View {
        VStack(alignment: .leading, spacing: 0) { // Use VStack to stack the line and buttons
            Rectangle()
                .fill(Color.gray) // Set the color of the line to gray
                .frame(height: 1) // Set the height of the line

            HStack {
                NavigationButton(title: "Dashboard", currentPage: $currentPage, destinationPage: "Dashboard", systemIconName: "house")
                NavigationButton(title: "Learn", currentPage: $currentPage, destinationPage: "Learn", systemIconName: "book")
                NavigationButton(title: "Credit", currentPage: $currentPage, destinationPage: "Credit", systemIconName: "creditcard")
                NavigationButton(title: "Wallet", currentPage: $currentPage, destinationPage: "Wallet", systemIconName: "dollarsign.circle")
                NavigationButton(title: "Invest", currentPage: $currentPage, destinationPage: "Settings", systemIconName: "person")
            }
            .padding()
            .frame(height: 60) // Height for footer buttons
            .background(Color.black)
        }
        .padding(.top, -5)
    }
}



struct NavigationButton: View {
    var title: String
    @Binding var currentPage: String
    var destinationPage: String
    var systemIconName: String

    var body: some View {
        Button(action: {
            currentPage = destinationPage
        }) {
            VStack {
                Image(systemName: currentPage == destinationPage ? "\(systemIconName).fill" : systemIconName)
                    .font(.system(size: 24))
                    .foregroundColor(currentPage == destinationPage ? Color("MainColor") : .white)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
        }
    }
}








struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
