//
//  DailyTriviaView.swift
//  Ahead
//
//  Created by Henry MacLane on 11/26/24.
//

import SwiftUI

struct DailyTriviaView: View {
    @State private var highestStreak: Int = 0 // Example streak value

    var body: some View {
        VStack(spacing: 16) {

            Text("Daily Trivia")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.bottom, 10.0)
            
            // Trivia Image at the Top
            Image("Trivia")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -20)
                         
            
            // Title Section
            Text("Trivia Stats")
                .font(.title2)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .bold()
                .padding(.leading, -165)
                .padding(.top, 10)
            
            // My Trivia Stats Section
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    // Daily Streak
                    VStack {
                        Image(systemName: "flame.fill")
                            .scaledToFit()
                            .font(.largeTitle)
                            .foregroundColor(highestStreak > 0 ? .orange : .gray)
                        Text("Daily Streak")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text("\(highestStreak)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    // Highest Streak
                    VStack {
                        Image(systemName: "flame.fill")
                            .scaledToFit()
                            .font(.largeTitle)
                            .foregroundColor(highestStreak > 0 ? .orange : .gray)
                        Text("Highest Streak")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text("\(highestStreak)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.gray)
                }
                .padding()
                .background(Color("BLACK2"))
                .cornerRadius(12)
            }
            .padding(.horizontal)
            
                Text("Options")
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.leading, 5)
                    .padding(.bottom, -25)
                
            HStack {
                Image(systemName: "arrow.2.squarepath")
                    .foregroundColor(Color.white)
                
                Text("Invite Friends")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
           .background(Color("BLACK2"))
           .cornerRadius(15)
           .padding()
           .padding(.horizontal, -10)
}
            Spacer()
            
            // Options Section
                Button(action: {
                    // Order card action
                }) {
                    Text("Answer Todays Trivia")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("MainColor"))
                        .cornerRadius(25)
                        .padding(.horizontal, -20)
                }
            .padding()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct DailyTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTriviaView()
    }
}
