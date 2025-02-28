//
//  Stock Page.swift
//  Ahead
//
//  Created by Henry MacLane on 10/4/24.
//

import SwiftUI
import SwiftUICharts

struct StockPage: View {
    @State private var selectedChart = "1d"
    @State private var showFullAbout = false
    @ObservedObject var viewModel: StockViewModel
    var stock: Stock

    var body: some View {
        ScrollView {
            VStack {
                // Header with Back Button, Ticker, and + Button
                headerView
                
                // Stock Header
                stockHeaderView
                
                // Stock Price
                stockPriceView
                
                // Last Updated
                lastUpdatedView
                
                // Chart Section
                chartView
                
                // Chart Buttons
                chartButtons
                
                // About Section
                aboutSection
                
                // Statistics Section
                statisticsSection
                
                // Latest News Section
                latestNewsSection
            }
            .padding()
        }
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchStockData()
        }
    }

    // Header View
    private var headerView: some View {
        HStack {
            Button(action: {
                // Action for back button
            }) {
                Image(systemName: "arrow.left")
                    .font(.title)
            }

            Spacer()

            Text(stock.symbol)
                .font(.title)
                .fontWeight(.bold)

            Spacer()

            Button(action: {
                // Action for + button
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
        }
        .padding()
    }

    // Stock Header View
    private var stockHeaderView: some View {
        HStack {
            if let logoURL = stock.logoURL, let url = URL(string: logoURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            }

            VStack(alignment: .leading) {
                Text(stock.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(stock.symbol)
                    .font(.title)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }

    // Stock Price View
    private var stockPriceView: some View {
        Text("Stock Price: $\(stock.price ?? 0.00, specifier: "%.2f")")
            .font(.title)
            .padding()
    }

    // Last Updated View
    private var lastUpdatedView: some View {
        Text("Last Updated: \(stock.lastUpdated ?? "N/A")")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.bottom)
    }

    private var chartView: some View {
        // Use a computed property instead of a local variable
        let chartData: [Double] = {
            switch selectedChart {
            case "1d":
                return viewModel.getDataFor1Day()
            case "1w":
                return viewModel.getDataFor1Week()
            case "1m":
                return viewModel.getDataFor1Month()
            case "1y":
                return viewModel.getDataFor1Year()
            case "ytd":
                return viewModel.getDataForYTD()
            case "all":
                return viewModel.getDataForAllTime()
            default:
                return []
            }
        }()

        return LineChartView(data: chartData, title: selectedChart, form: ChartForm.large)
            .padding()
    }


    // Chart Buttons
    private var chartButtons: some View {
        HStack {
            ForEach(["1d", "1w", "1m", "1y", "ytd", "all"], id: \.self) { period in
                Button(period.uppercased()) {
                    selectedChart = period
                }
                .padding()
                .background(selectedChart == period ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
    }

    // About Section
    private var aboutSection: some View {
        VStack(alignment: .leading) {
            Text("About")
                .font(.headline)
                .padding(.bottom, 2)

            if let description = stock.description {
                Text(showFullAbout ? description : String(description.prefix(100)) + "...")
                    .padding(.bottom, 2)

                Button(showFullAbout ? "Show Less" : "Show More") {
                    showFullAbout.toggle()
                }
            }
        }
        .padding()
    }

    // Statistics Section
    private var statisticsSection: some View {
        VStack(alignment: .leading) {
            Text("Statistics")
                .font(.headline)
                .padding(.bottom, 2)

            HStack {
                Text("Market Cap: $XXX.XX") // Placeholder for market cap
                Spacer()
                Text("PE Ratio: XX.X") // Placeholder for PE Ratio
            }
        }
        .padding()
    }

    // Latest News Section
    private var latestNewsSection: some View {
        VStack(alignment: .leading) {
            Text("Latest News")
                .font(.headline)
                .padding(.bottom, 2)

            // Replace with actual news data
            ForEach(0..<3) { index in
                Text("News headline \(index + 1)")
            }
        }
        .padding()
    }
}

struct StockPage_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStock = Stock(
            symbol: "AAPL",
            name: "Apple Inc.",
            logoURL: "https://logo.clearbit.com/apple.com",
            description: "Apple Inc. is an American multinational technology company headquartered in Cupertino, California.",
            price: 150.00,
            lastUpdated: "2024-10-15"
        )
        StockPage(viewModel: StockViewModel(), stock: sampleStock)
    }
}
