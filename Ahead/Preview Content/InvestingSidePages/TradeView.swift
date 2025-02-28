//
//  TradeView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/17/24.
//


import SwiftUI

struct TradeView: View {
    @ObservedObject var stockViewModel: StockViewModel
    var stock: Stock
    @State private var shareAmount: Double = 1
    @State private var estimatedAmount: Double = 51.83

    var body: some View {
        VStack(spacing: 20) {
            // Header Section (Title)
            Text("Buy \(stock.symbol)")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            // Logo Section
            if let logoURL = stock.logoURL, let url = URL(string: logoURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 80, height: 80)
                }
            }

            // Share Input Section
            Text("I want to buy")
                .font(.title2)
            Text("\(shareAmount, specifier: "%.5f") \(stock.symbol)")
                .font(.title)
                .bold()

            // Shares and Estimated Amount Info
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Shares")
                    Spacer()
                    Text("\(shareAmount, specifier: "%.5f")")
                }

                HStack {
                    Text("Estimated amount")
                    Spacer()
                    Text("$\(estimatedAmount, specifier: "%.2f")")
                }
            }
            .padding(.horizontal)

            Divider()
            // Info Disclaimer
            Text("""
                If you place this order by 3:00 PM ET on 10/18/2024, your order will be executed \
                the same day at the market closing price. The actual value of this sale may change \
                if the market closing price is different than the current price. Investing involves \
                risk, including possible loss of principal. Past performance does not guarantee future results.
                """)
                .font(.caption)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()

            // Confirm Button
            Button(action: {
                print("Buying \(shareAmount) \(stock.symbol)")
            }) {
                Text("Confirm Buy")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

// Preview the SwiftUI View
struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        let stockViewModel = StockViewModel()
        let sampleStock = stockViewModel.mockStock()

        TradeView(stockViewModel: stockViewModel, stock: sampleStock)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
