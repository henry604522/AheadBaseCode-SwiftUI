//
//  Credit.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct Credit: View {
    @State private var creditScore: Int = 732
    @State private var pointsSince: Int = 21
    @State private var pointsSinceDate: String = "10/01/2024"
    @State private var showInfoAlert: Bool = false
    
    let startColor = Color("SecondColor")
    let endColor = Color("MainColor")
    
    func gradientForScore(_ score: Int) -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [startColor, endColor]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Rounded rectangle around credit score text, TransUnion text, and points info
                VStack(spacing: 5) {
                    Text("Credit Builder")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("TransUnion | Vantage Score 4.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Semicircle and circles inside GeometryReader for scaling
                    GeometryReader { geometry in
                        ZStack {
                            // Left half of the circle in MainColor
                            Circle()
                                .trim(from: 0.0, to: 0.35)
                                .stroke(Color("MainColor"), lineWidth: 20)
                                .rotationEffect(Angle(degrees: 140))
                            
                            // Right half of the circle in white
                            Circle()
                                .trim(from: 0.35, to: 0.7)
                                .stroke(Color.white, lineWidth: 20)
                                .rotationEffect(Angle(degrees: 140))
                            
                            // The colored part of the semicircle based on credit score
                            Circle()
                                .trim(from: 0.0, to: CGFloat(Double(creditScore) / 850.0 * 0.7))
                                .stroke(gradientForScore(creditScore), lineWidth: 20)
                                .rotationEffect(Angle(degrees: 160))
                                .animation(.easeInOut, value: creditScore)
                            
                            // Small circles for visual decoration
                            let smallCircleRadius: CGFloat = 10
                            
                            Circle()
                                .fill(Color("MainColor"))
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: -90, y: 71.5)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: 98, y: 60)
                            
                            Circle()
                                .fill(Color("SecondColor"))
                                .frame(width: smallCircleRadius * 2, height: smallCircleRadius * 2)
                                .offset(x: 110, y: 30)
                            
                            // Credit score text
                            VStack(spacing: 5) {
                                Text("\(creditScore)")
                                    .font(.system(size: 55, weight: .bold))
                                    .foregroundColor(.white)
                                
                                HStack {
                                    Text("Good")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    
                                    Button(action: {
                                        showInfoAlert = true
                                    }) {
                                        Image(systemName: "info.circle")
                                            .foregroundColor(.gray)
                                    }
                                    .alert(isPresented: $showInfoAlert) {
                                        Alert(title: Text("Information"), message: Text("Your credit score is better than average"), dismissButton: .default(Text("OK")))
                                    }
                                }
                            }
                            .offset(y: 20)
                        }
                        .frame(width: 230, height: 230) // Smaller frame for the semicircle and circles
                        .padding()
                        .background(Color("BLACK2"))
                        .cornerRadius(20)
                        .scaleEffect(1.05) // Scale down the circle to 80% of its size
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the circle inside the GeometryReader
                    }
                    .frame(height: 250) // Keep the same height for the entire container
                    
                    Text("+\(pointsSince) points since \(pointsSinceDate)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(.top, -20)
                    
                }
                .padding()
                .padding(.horizontal, 25)
                .background(Color("BLACK2"))
                .cornerRadius(20)
                
                NavigationLink(destination: Notifications()) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 75)
                        .overlay(
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Next Payment")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .font(.caption)
                                    Text("$49.98")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .font(.title)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                                
                            }
                                .padding()
                        )
                        .padding()
                }
                .padding(.horizontal, -15)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Manage Your Credit")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading, -15)
                    
                    NavigationLink(destination: Notifications()) {
                        HStack {
                            Image(systemName: "calendar")
                                .font(.title)
                                .foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text("Next Payment Due")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("November 30, 2024")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("BLACK2"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, -15)
                    
                    NavigationLink(destination: AccStatements()) {
                        HStack {
                            Image(systemName: "chart.bar.xaxis")
                                .font(.title)
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Credit Statements")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Track your progress")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("BLACK2"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, -15)
                    
                    NavigationLink(destination: Learn()) {
                        HStack {
                            Image(systemName: "lightbulb")
                                .font(.title)
                                .foregroundColor(.orange)
                            VStack(alignment: .leading) {
                                Text("Learn How to Boost Credit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Get started with helpful tips")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color("BLACK2"))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, -15)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .background(Color(.black))
        }
        .background(Color(.black).ignoresSafeArea())
        .navigationBarBackButtonHidden(true) // This hides the default back button
    }
}

struct Credit_Previews: PreviewProvider {
    static var previews: some View {
        Credit()
    }
}



