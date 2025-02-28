//
//  CreditCrusher.swift
//  Ahead
//
//  Created by Henry MacLane on 12/24/24.
//

import SwiftUI
import AVFoundation

struct CreditCrusherGame: View {
    @State private var gameStarted = false
    @State private var player: AVAudioPlayer?
   
    var body: some View {
        if gameStarted {
            GameView()
        } else {
            MenuView(gameStarted: $gameStarted)
                .onAppear {
                    playMusic()
                }
        }
    }
   
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.numberOfLoops = -1 // Loop indefinitely
        player?.play()
    }
}

struct MenuView: View {
    @Binding var gameStarted: Bool
   
    var body: some View {
        ZStack {
            AnimatedBackground()
            VStack {
                Text("Credit Crusher Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
               
                Button(action: {
                    gameStarted = true
                }) {
                    Text("Play")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct AnimatedBackground: View {
    @State private var animate = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<5) { i in
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.red, Color.blue, Color.green, Color.orange, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))
                        .frame(width: CGFloat(150 + i * 100), height: CGFloat(150 + i * 100))
                        .position(
                            x: animate ? CGFloat.random(in: 0...geometry.size.width) : CGFloat.random(in: 0...geometry.size.width),
                            y: animate ? CGFloat.random(in: 0...geometry.size.height) : CGFloat.random(in: 0...geometry.size.height)
                        )
                        .animation(Animation.linear(duration: 10).repeatForever(autoreverses: true))
                }
            }
            .onAppear {
                animate.toggle()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GameView: View {
    @StateObject private var gameModel = GameModel()

    var body: some View {
        VStack {
            HStack {
                Text("Age: \(gameModel.age)")
                    .font(.headline)
                    .padding()
                Spacer()
                Text("Credit Score: \(gameModel.creditScoreString)")
                    .font(.headline)
                    .padding()
            }

            Spacer()

            if let currentPrompt = gameModel.currentPrompt {
                Text(currentPrompt.description)
                    .font(.title2)
                    .padding()

                ForEach(currentPrompt.options) { option in
                    Button(action: {
                        gameModel.applyDecision(option)
                    }) {
                        Text(option.text)
                            .font(.title3)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.bottom, 10)
                    }
                }
            } else {
                Text("Congratulations! You've reached age 50!")
                    .font(.title2)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
}

class GameModel: ObservableObject {
    @Published var age: Int = 12
    @Published var creditScore: Int? = nil
    @Published var currentPrompt: Prompt?
   
    private var prompts: [Prompt] = []
   
    var creditScoreString: String {
        if let score = creditScore {
            return String(score)
        } else {
            return "N/A"
        }
    }
   
    init() {
        setupPrompts()
        currentPrompt = prompts.first
    }
   
    func applyDecision(_ decision: DecisionOption) {
        if decision.effectOnCreditScore != 0 {
            creditScore = (creditScore ?? 0) + decision.effectOnCreditScore
        } else if creditScore == nil {
            creditScore = 740
        }
        age += decision.ageIncrement
        currentPrompt = prompts.first { $0.age == age }
    }
   
    private func setupPrompts() {
        prompts = [
            Prompt(age: 12, description: "Download Ahead to build early credit or choose 'I'm Good'.", options: [
                DecisionOption(text: "Download Ahead", effectOnCreditScore: 740, ageIncrement: 6),
                DecisionOption(text: "I'm Good", effectOnCreditScore: 0, ageIncrement: 6)
            ]),
            Prompt(age: 18, description: "Apply for a secured credit card or ignore.", options: [
                DecisionOption(text: "Apply for Secured Credit Card", effectOnCreditScore: 30, ageIncrement: 4),
                DecisionOption(text: "Ignore", effectOnCreditScore: -10, ageIncrement: 4)
            ]),
            // Add more prompts for ages 22, 26, 30, 34, 38, 42, 46, 50
            Prompt(age: 22, description: "Pay off student loans or defer payments.", options: [
                DecisionOption(text: "Pay off Loans", effectOnCreditScore: 40, ageIncrement: 4),
                DecisionOption(text: "Defer Payments", effectOnCreditScore: -20, ageIncrement: 4)
            ]),
            Prompt(age: 26, description: "Buy a car with a loan or save up.", options: [
                DecisionOption(text: "Buy with Loan", effectOnCreditScore: -30, ageIncrement: 4),
                DecisionOption(text: "Save Up", effectOnCreditScore: 20, ageIncrement: 4)
            ]),
            Prompt(age: 30, description: "Apply for a mortgage or rent.", options: [
                DecisionOption(text: "Apply for Mortgage", effectOnCreditScore: -40, ageIncrement: 4),
                DecisionOption(text: "Rent", effectOnCreditScore: 10, ageIncrement: 4)
            ]),
            Prompt(age: 34, description: "Pay credit card bill on time or miss a payment.", options: [
                DecisionOption(text: "Pay on Time", effectOnCreditScore: 30, ageIncrement: 4),
                DecisionOption(text: "Miss Payment", effectOnCreditScore: -50, ageIncrement: 4)
            ]),
            Prompt(age: 38, description: "Increase credit limit or keep it the same.", options: [
                DecisionOption(text: "Increase Limit", effectOnCreditScore: 20, ageIncrement: 4),
                DecisionOption(text: "Keep Same", effectOnCreditScore: 0, ageIncrement: 4)
            ]),
            Prompt(age: 42, description: "Get a new credit card or stick with the old one.", options: [
                DecisionOption(text: "New Credit Card", effectOnCreditScore: -10, ageIncrement: 4),
                DecisionOption(text: "Stick with Old", effectOnCreditScore: 10, ageIncrement: 4)
            ]),
            Prompt(age: 46, description: "Co-sign a loan for a friend or refuse.", options: [
                DecisionOption(text: "Co-sign Loan", effectOnCreditScore: -30, ageIncrement: 4),
                DecisionOption(text: "Refuse", effectOnCreditScore: 10, ageIncrement: 4)
            ]),
            Prompt(age: 50, description: "Review credit report for errors or ignore.", options: [
                DecisionOption(text: "Review Report", effectOnCreditScore: 20, ageIncrement: 4),
                DecisionOption(text: "Ignore", effectOnCreditScore: -20, ageIncrement: 4)
            ])
        ]
    }
}

struct Prompt: Identifiable {
    let id = UUID()
    let age: Int
    let description: String
    let options: [DecisionOption]
}

struct DecisionOption: Identifiable {
    let id = UUID()
    let text: String
    let effectOnCreditScore: Int
    let ageIncrement: Int
}

struct CreditCrusherGame_Previews: PreviewProvider {
    static var previews: some View {
        CreditCrusherGame()
    }
}
