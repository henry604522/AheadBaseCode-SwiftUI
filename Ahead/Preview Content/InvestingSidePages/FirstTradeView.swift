//
//  FirstTradeView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/17/24.
//

import SwiftUI

struct FirstTradeView: View {
    @State private var inputAmount: String = ""
    @State private var availableIAU: Double = 1.01964

    var body: some View {
        VStack(spacing: 30) {
            Text("Sell IAU")
                .font(.headline)
                .padding(.top)

            Text("Available to sell: \(availableIAU, specifier: "%.5f") IAU")
                .font(.subheadline)

            // Percentage Buttons
            HStack(spacing: 20) {
                PercentageButton(title: "25%", action: {
                    setAmount(percentage: 0.25)
                })

                PercentageButton(title: "50%", action: {
                    setAmount(percentage: 0.50)
                })

                PercentageButton(title: "Sell All", action: {
                    inputAmount = "\(availableIAU)"
                })
            }

            // Numeric Keypad
            VStack {
                ForEach([["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], [".", "0", "⌫"]], id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                handleKeyPress(item)
                            }) {
                                Text(item)
                                    .font(.largeTitle)
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }

            // Next Button
            Button(action: {
                // Perform the selling action here
                print("Selling \(inputAmount) IAU")
            }) {
                Text("Next")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }

    // Helper Functions
    private func setAmount(percentage: Double) {
        let amount = availableIAU * percentage
        inputAmount = String(format: "%.5f", amount)
    }

    private func handleKeyPress(_ key: String) {
        if key == "⌫" {
            inputAmount = String(inputAmount.dropLast())
        } else {
            inputAmount.append(key)
        }
    }
}

struct PercentageButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(width: 80, height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

// Preview
struct FirstTradeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTradeView()
    }
}
