//
//  Notifications.swift
//  Ahead
//
//  Created by Henry MacLane on 10/18/24.
//

import SwiftUI

struct Notifications: View {
    @State private var selectedSection: String = "Notifications"
    
    let transactions = [
        Transaction(category: .shopping, amount: "$898.23", merchant: "Apple", date: "2023-11-22", status: "Completed"),
        Transaction(category: .food, amount: "$49.97", merchant: "Shake Shack", date: "2023-11-20", status: "Pending")
    ].sorted { $0.date > $1.date } // Sort transactions by date

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                HStack(spacing: 20) { // Decreased spacing between icons
                    // General Notifications
                    NotificationIcon(iconName: "bell.fill", title: "Notifications", selectedSection: $selectedSection)
                    
                    // Transactions
                    NotificationIcon(iconName: "dollarsign.circle.fill", title: "Transactions", selectedSection: $selectedSection)
                    
                    // Credit
                    NotificationIcon(iconName: "creditcard.fill", title: "Credit", selectedSection: $selectedSection)
                }
                .padding(.top)
                .frame(maxWidth: .infinity)

                Divider() // Adding a white divider
                    .background(Color.white)
                    .frame(height: 1) // Set divider height
                    .padding(.horizontal)
            }

            ScrollView {
                VStack(spacing: 20) {
                    if selectedSection == "Notifications" || selectedSection == "Transactions" {
                        TransactionList(transactions: transactions)
                    } else if selectedSection == "Credit" {
                        NotificationContent(title: "Credit", message: "No credit history")
                    }
                }
                .padding(.top)
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .foregroundColor(.white)
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let category: Category
    let amount: String
    let merchant: String
    let date: String
    let status: String
    
    enum Category {
        case food
        case transportation
        case shopping
        // Add more categories as needed
    }
    
    var icon: String {
        switch category {
        case .food: return "fork.knife"
        case .transportation: return "car"
        case .shopping: return "bag"
        }
    }
    
    var color: Color {
        switch category {
        case .food: return Color("MainColor")
        case .transportation: return Color("MainColor")
        case .shopping: return Color("MainColor")
        }
    }
}

struct NotificationIcon: View {
    let iconName: String
    let title: String
    @Binding var selectedSection: String

    var body: some View {
        VStack {
            Button(action: {
                selectedSection = title
            }) {
                VStack {
                    Image(systemName: iconName)
                        .font(.system(size: 24))
                    Text(title)
                        .font(.headline)
                        .lineLimit(1)
                }
                .foregroundColor(.white) // Keeps the color the same when selected
            }
        }
    }
}

struct NotificationContent: View {
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

struct TransactionList: View {
    let transactions: [Transaction]
    
    var body: some View {
        VStack {
            ForEach(transactions) { transaction in
                VStack {
                    HStack {
                        Image(systemName: transaction.icon)
                            .font(.system(size: 24))
                            .foregroundColor(transaction.color)
                        
                        VStack(alignment: .leading) {
                            Text(transaction.merchant)
                                .font(.headline)
                            
                            Text(transaction.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(transaction.amount)
                                .font(.headline)
                            
                            Text(transaction.status)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    Divider()
                        .background(Color.white)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Notifications()
}









