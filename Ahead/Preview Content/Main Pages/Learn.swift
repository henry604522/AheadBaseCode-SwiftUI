//
//  Learn.swift
//  Ahead
//
//  Created by Henry MacLane on 10/1/24.
//

import SwiftUI
import WebKit

// WebKitView for displaying a webpage
struct WebKitView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

extension Color {
    static let MainColor = Color("MainColor") // Make sure "MainColor" is defined in your asset catalog
}

extension Color {
    static let SecondColor = Color("SecondColor")
}

struct Learn: View {
    @State private var triviaScore: Int = 0
    @State private var showWebView = false
    @State private var webURL: URL?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                // Header Section
                Text("Learn")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black) // Set header background to black
                
                // For You Section
                Text("For You")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading) // Center the title text
                
                // Continue Reading Icons (smaller)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<4) { i in
                            VStack {
                                Image(systemName: iconForForYouSection(index: i))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40) // Smaller icons
                                    .foregroundColor(colorForForYouSection(index: i))
                                
                                Text(titleForForYouSection(index: i)) // Custom titles
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .frame(width: 100, alignment: .center) // Keep text centered

                                Text(descriptionForForYouSection(index: i)) // Custom descriptions
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                    .frame(width: 100, alignment: .center)
                            }
                            .frame(width: 120, height: 120)
                            .background(Color("BLACK2"))
                            .cornerRadius(10)
                            .onTapGesture {
                                webURL = URL(string: "https://example.com") // Placeholder URL
                                showWebView = true
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                VStack{
                    Divider().background(Color.white)
                }
                .padding(.top)
                
                // Trivia Section
                
                Text("Daily Trivia")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.leading, 15)
                
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
                                .foregroundColor(triviaScore == 0 ? .gray : .orange) // Set color based on dailyStreak
                            
                            
                            Text("\(triviaScore)")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                    .padding()
                    .background(Color("BLACK2"))
                    .cornerRadius(20)
                
                VStack {
                    Divider()
                }
                .background(Color.white)
                .padding(.vertical)
                
                // Articles Section
                Text("Articles")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                
                ForEach(0..<5) { i in
                    HStack {
                        Image(systemName: iconForArticles(index: i))
                            .font(.title)
                            .foregroundColor(colorForArticles(index: i))
                        
                        VStack(alignment: .leading) {
                            Text(titleForArticles(index: i)) // Custom title
                                .font(.headline)
                                .foregroundColor(.white)
                                .lineLimit(1) // Limit the text to one line
                            Text(descriptionForArticles(index: i)) // Custom description
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("BLACK2"))
                    .cornerRadius(15)
                    .onTapGesture {
                        webURL = URL(string: "https://example.com") // Placeholder URL
                        showWebView = true
                    }
                }
            }
            .padding(10)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showWebView) {
            if let url = webURL {
                WebKitView(url: url) // Use the WebKitView to display the URL
            }
        }
}
        

    // Helper function to return icons for the "For You" section
    func iconForForYouSection(index: Int) -> String {
        switch index {
        case 0: return "creditcard.fill"
        case 1: return "dollarsign.bank.building.fill"
        case 2: return "chart.line.uptrend.xyaxis.circle"
        default: return "dollarsign.circle"
        }
    }
    
    // Helper function to return colors for the "For You" section
    func colorForForYouSection(index: Int) -> Color {
        switch index {
        case 0: return .MainColor
        case 1: return .MainColor
        case 2: return .MainColor
        default: return .MainColor
        }
    }

    // Helper function to return custom titles for the "For You" section
    func titleForForYouSection(index: Int) -> String {
        switch index {
        case 0: return "Intro to Credit"
        case 1: return "Saving Intro"
        case 2: return "Boost Credit"
        default: return "Spend Wisely"
        }
    }
    
    // Helper function to return custom descriptions for the "For You" section
    func descriptionForForYouSection(index: Int) -> String {
        switch index {
        case 0: return ""
        case 1: return ""
        case 2: return ""
        default: return ""
        }
    }

    // Helper function to return icons for the "Articles" section
    func iconForArticles(index: Int) -> String {
        switch index {
        case 0: return "creditcard.fill"
        case 1: return "dollarsign.arrow.trianglehead.counterclockwise.rotate.90"
        case 2: return "dollarsign.bank.building.fill"
        case 3: return "chart.line.uptrend.xyaxis.circle"
        default: return "dollarsign.circle"

        }
    }

    // Helper function to return colors for the "Articles" section
    func colorForArticles(index: Int) -> Color {
        switch index {
        case 0: return .MainColor
        case 1: return .MainColor
        case 2: return .MainColor
        case 3: return .MainColor
        default: return .MainColor
        }
    }
    
    // Helper function to return custom titles for the "Articles" section
    func titleForArticles(index: Int) -> String {
        switch index {
        case 0: return "Intro to Credit"
        case 1: return "Intro to Saving"
        case 2: return "Smart Spending"
        case 3: return "How to Boost Credit"
        default: return "How to Make Money"
        }
    }
    
    // Helper function to return custom descriptions for the "Articles" section
    func descriptionForArticles(index: Int) -> String {
        switch index {
        case 0: return "Learn the tool that can benefit your future."
        case 1: return "Understand how smart saving habits can benifit your future."
        case 2: return "Learn how to manage your spending wisely."
        case 3: return "A higher credit score means more opportunities in your future."
        default: return "Learn how to take your balance from zero to $100"
        }
    }
}



#Preview {
    Learn()
}












