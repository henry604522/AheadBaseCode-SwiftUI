//
//  StockViewModel.swift
//  Ahead
//
//  Created by Henry MacLane on 10/4/24.
//

import Foundation

class StockViewModel: ObservableObject {
    @Published var stocks: [Stock] = []
    private let apiKey = "f898b00cd0d9422da06a14f63e7b180a"

    // Example data for charting, assuming it's a placeholder for your actual logic
    private var exampleChartData: [String: [Double]] = [
        "1d": [150.00, 152.00, 148.00, 153.00],
        "1w": [148.00, 150.00, 152.00, 151.00, 153.00],
        "1m": [145.00, 148.00, 152.00, 150.00],
        "1y": [135.00, 140.00, 145.00, 150.00],
        "ytd": [140.00, 145.00, 150.00],
        "all": [100.00, 120.00, 140.00, 160.00]
    ]

    func fetchStockData() {
        let symbols = ["VOO", "QQQ", "DIA", "BTC-USD"]
        let group = DispatchGroup()

        for symbol in symbols {
            group.enter()
            guard let url = URL(string: "https://api.twelvedata.com/quote?symbol=\(symbol)&apikey=\(apiKey)") else {
                print("Invalid URL for symbol: \(symbol)")
                group.leave()
                continue
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                defer { group.leave() }
                
                if let error = error {
                    print("Error fetching stock data for \(symbol): \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data returned from API for \(symbol).")
                    return
                }
                
                do {
                    let stockResponse = try JSONDecoder().decode(StockResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Check if the stock already exists in the list
                        if let index = self?.stocks.firstIndex(where: { $0.symbol == stockResponse.data.symbol }) {
                            self?.stocks[index] = stockResponse.data // Update existing stock
                        } else {
                            self?.stocks.append(stockResponse.data) // Add new stock
                        }
                        print("Stock fetched: \(stockResponse.data)")  // Debugging line
                    }
                } catch {
                    print("Error decoding JSON for \(symbol): \(error)")
                }
            }.resume()
        }

        group.notify(queue: .main) {
            print("All stocks fetched: \(self.stocks)")
        }
    }

    // Function to provide a mock stock for previews
    func mockStock() -> Stock {
        return Stock(symbol: "AAPL",
                     name: "Apple Inc.",
                     logoURL: "https://upload.wikimedia.org/wikipedia/en/f/fa/Apple_logo_black.svg",
                     description: "Apple Inc. is an American multinational technology company.",
                     price: 150.00,
                     lastUpdated: "2024-10-17T12:00:00Z")
    }

    // Chart data methods for different time periods
    func getDataFor1Day() -> [Double] {
        return exampleChartData["1d"] ?? []
    }

    func getDataFor1Week() -> [Double] {
        return exampleChartData["1w"] ?? []
    }

    func getDataFor1Month() -> [Double] {
        return exampleChartData["1m"] ?? []
    }

    func getDataFor1Year() -> [Double] {
        return exampleChartData["1y"] ?? []
    }

    func getDataForYTD() -> [Double] {
        return exampleChartData["ytd"] ?? []
    }

    func getDataForAllTime() -> [Double] {
        return exampleChartData["all"] ?? []
    }
}
