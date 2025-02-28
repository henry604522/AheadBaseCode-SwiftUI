//
//  Investing.swift
//  Ahead
//
//  Created by Henry MacLane on 10/1/24.
//
//

import SwiftUI
import Charts

struct InvestPageView: View {
    @State private var hoveredValue: (day: Int, value: Double)? = nil
    @State private var selectedPeriod: String? = "   1D     "
    @ObservedObject var stockViewModel = StockViewModel()

    var body: some View {
        VStack {

            
            ScrollView {
                // Profile Header
                
                // Investment Overview
                Text("Investing Overview")
                    .font(.largeTitle)

                VStack {
                    Text("$4,205.24")
                        .font(.largeTitle)
                        .bold()
                    Text("+102.73 (3.2%)")
                        .foregroundColor(.green)
                        .font(.subheadline)
                }
                .padding(.horizontal)

                VStack {
                    // Chart Section
                    Chart {
                        ForEach(filteredChartData(), id: \.day) { data in
                            LineMark(
                                x: .value("Day", data.day),
                                y: .value("Value", data.value)
                            )
                            .interpolationMethod(.catmullRom) // Smooth line
                        }
                        if let hoveredValue = hoveredValue {
                            RuleMark(x: .value("Day", hoveredValue.day))
                                .annotation(position: .top) {
                                    Text("\(hoveredValue.value, specifier: "%.2f")")
                                        .font(.caption)
                                        .padding(5)
                                        .background(Color.gray.opacity(0.7))
                                        .cornerRadius(5)
                                        .foregroundColor(.white)
                                }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(position: .trailing) { _ in
                            AxisGridLine().foregroundStyle(.clear)
                            AxisTick().foregroundStyle(.clear)
                            AxisValueLabel().foregroundStyle(.clear)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { _ in
                            AxisGridLine().foregroundStyle(.clear)
                            AxisTick().foregroundStyle(.clear)
                            AxisValueLabel().foregroundStyle(.clear)
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
                                            let location = value.location
                                            if let day: Int = proxy.value(atX: location.x),
                                               let value: Double = proxy.value(atY: location.y) {
                                                hoveredValue = (day, value)
                                            }
                                        }
                                        .onEnded { _ in
                                            hoveredValue = nil
                                        }
                                )
                        }
                    }
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
                .padding(.top, 100)

                // Period Buttons
                HStack {
                    PeriodButton2(title: "   1D     ", selectedPeriod: $selectedPeriod)
                    PeriodButton2(title: "   7D     ", selectedPeriod: $selectedPeriod)
                    PeriodButton2(title: "  30D     ", selectedPeriod: $selectedPeriod)
                    PeriodButton2(title: "  90D     ", selectedPeriod: $selectedPeriod)
                    PeriodButton2(title: "   1Y     ", selectedPeriod: $selectedPeriod)
                    PeriodButton2(title: "  ALL     ", selectedPeriod: $selectedPeriod)
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)

                // Scrollable Chart Placeholder
                ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                // S&P 500
                                if let vooStock = stockViewModel.stocks.first(where: { $0.symbol == "VOO" }) {
                                    NavigationLink(destination: StockPage(viewModel: stockViewModel, stock: vooStock)) {
                                        VStack {
                                            Text("Top 500")
                                                .foregroundStyle(Color.black)
                                            Text("+0.52%") // Placeholder for the actual percentage change
                                                .foregroundColor(.green)
                                        }
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                            
                                        .cornerRadius(10)
                                    }
                                }

                                // NASDAQ
                                if let qqqStock = stockViewModel.stocks.first(where: { $0.symbol == "QQQ" }) {
                                    NavigationLink(destination: StockPage(viewModel: stockViewModel, stock: qqqStock)) {
                                        VStack {
                                            Text("Tech")
                                                .foregroundStyle(Color.black)
                                            Text("+0.45%") // Placeholder for the actual percentage change
                                                .foregroundColor(.green)
                                        }
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }

                                // Dow Jones
                                if let diaStock = stockViewModel.stocks.first(where: { $0.symbol == "DIA" }) {
                                    NavigationLink(destination: StockPage(viewModel: stockViewModel, stock: diaStock)) {
                                        VStack {
                                            Text("Industrials")
                                                .foregroundStyle(Color.black)
                                            Text("+0.72%") // Placeholder for the actual percentage change
                                                .foregroundColor(.green)
                                        }
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                        
                                        .cornerRadius(10)
                                    }
                                }

                                // Bitcoin
                                if let btcStock = stockViewModel.stocks.first(where: { $0.symbol == "BTC-USD" }) {
                                    NavigationLink(destination: StockPage(viewModel: stockViewModel, stock: btcStock)) {
                                        VStack {
                                            Text("Bitcoin")
                                                .foregroundStyle(Color.black)
                                            Text("-1.75%") // Placeholder for the actual percentage change
                                                .foregroundColor(.red)
                                        }
                                        .frame(width: 100, height: 100)
                                        .background(Color.white)
                                       
                                        .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                        .onAppear {
                            stockViewModel.fetchStockData()
                        }
                
                Divider()

                // Portfolio Section
                VStack(alignment: .leading) {
                    Text("My Portfolio")
                        .font(.headline)
                    VStack {
                        Text("No Stocks")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center) // Center align the text
                            .lineLimit(1) // Ensure the text stays on one line
                    }
                    .frame(width: 300, height: 300) // Set minimum height to 200
                    .background(Color.white) // Background color
                    .cornerRadius(20) // Corner radius
                    .shadow(radius: 3) // Shadow effect
                    .padding(.horizontal, 20) // Outer horizontal padding
                    .padding()

                    
                    // Portfolio Button
                    Button(action: {
                            // Place Order action
                        }) {
                            Text("Place Order")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .background(Color("MainColor"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    
                }
                .padding()

                Divider()

                // Watchlist Section
                VStack(alignment: .center) {
                    HStack {
                        Text("Watchlist")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Button(action: {
                            // Add to watchlist
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                    .padding(.bottom, 4)
                    VStack {
                        Text("No Stocks")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center) // Center align the text
                            .lineLimit(1) // Ensure the text stays on one line
                    }
                    .frame(width: 300, height: 300) // Set minimum height to 200
                    .background(Color.white) // Background color
                    .cornerRadius(20) // Corner radius
                    .shadow(radius: 3) // Shadow effect
                    .padding(.horizontal, 20) // Outer horizontal padding
                }
                .padding()
                Spacer()
            }
            

            // Sticky Footer
            
        }
    }
    
    // Filter the chart data based on the selected period
    func filteredChartData() -> [ChartData] {
        guard let period = selectedPeriod else { return sAndP500Data }
        switch period.trimmingCharacters(in: .whitespaces) {
        case "1D":
            return Array(sAndP500Data.suffix(1))
        case "7D":
            return Array(sAndP500Data.suffix(7))
        case "30D":
            return Array(sAndP500Data.suffix(30))
        case "90D":
            return Array(sAndP500Data.suffix(90))
        case "1Y":
            return Array(sAndP500Data.suffix(365))
        case "ALL":
            return sAndP500Data
        default:
            return sAndP500Data
        }
    }
}

// S&P 500 data for the last 30 days (Sample Data)
struct ChartData: Identifiable {
    let id = UUID()
    let day: Int
    let value: Double
}

let sAndP500Data = [
    ChartData(day: 1, value: 3971.70),
    ChartData(day: 2, value: 3984.03),
    ChartData(day: 3, value: 3974.15),
    ChartData(day: 4, value: 3988.85),
    ChartData(day: 5, value: 4002.09),
    ChartData(day: 6, value: 4011.30),
    ChartData(day: 7, value: 4020.45),
    ChartData(day: 8, value: 4001.20),
    ChartData(day: 9, value: 4015.05),
    ChartData(day: 10, value: 4035.50),
    ChartData(day: 11, value: 4040.85),
    ChartData(day: 12, value: 4055.60),
    ChartData(day: 13, value: 4040.15),
    ChartData(day: 14, value: 4030.90),
    ChartData(day: 15, value: 4045.75),
    ChartData(day: 16, value: 4050.00),
    ChartData(day: 17, value: 4070.25),
    ChartData(day: 18, value: 4065.10),
    ChartData(day: 19, value: 4080.80),
    ChartData(day: 20, value: 4095.45),
    ChartData(day: 21, value: 4100.00),
    ChartData(day: 22, value: 4115.70),
    ChartData(day: 23, value: 4130.15),
    ChartData(day: 24, value: 4120.80),
    ChartData(day: 25, value: 4140.45),
    ChartData(day: 26, value: 4155.20),
    ChartData(day: 27, value: 4160.55),
    ChartData(day: 28, value: 4175.90),
    ChartData(day: 29, value: 4190.30),
    ChartData(day: 30, value: 4205.24)
]

struct PeriodButton2: View {
    var title: String
    @Binding var selectedPeriod: String?
    
    var body: some View {
        Button(action: {
            selectedPeriod = title
        }) {
            Text(title)
                .font(.body)
                .padding(5)
                .background(selectedPeriod == title ? Color("MainColor") : Color.white)
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

struct InvestPageView_Previews: PreviewProvider {
    static var previews: some View {
        InvestPageView()
    }
}
