//
//  Recent transactions.swift
//  Ahead
//
//  Created by Henry MacLane on 10/7/24.
//

import SwiftUI

struct RecentTransactions: View {
    // State variable to manage the selected sort option
    @State private var selectedSortOption = "Sort by"
    // Dropdown options
    private let sortOptions: [(String, String)] = [
        ("Price", "chevron.down"),
        ("Price", "chevron.up"),
        ("Date", "calendar"),
        ("Date", "calendar.badge.clock")
    ]

    var body: some View {
        ScrollView { // Make the view scrollable
            VStack(alignment: .leading, spacing: 16) {
                // Title and Dropdown in HStack
                HStack {
                    Text("Recent Transactions")
                        .font(.title2)

                    // Dropdown menu
                    Menu {
                        // Create menu items from sortOptions
                        ForEach(sortOptions, id: \.0) { option in
                            Button(action: {
                                selectedSortOption = option.0
                            }) {
                                HStack {
                                    Text(option.0) // Option text
                                    Spacer()
                                    Image(systemName: option.1) // Option icon
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedSortOption)
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding(.leading, 20)
                }
                .padding(.horizontal)

                // Full-width white rectangle for transactions
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity) // Fill the width of the screen
                    .overlay(
                        Text("No transactions to display")
                            .foregroundColor(.gray)
                    )
                    .frame(height: 700) // Set a fixed height for the rectangle
                    .padding(.horizontal)

                Spacer() // Added to push content to the top if needed
            }
            .padding()
            
        }
        .navigationBarTitleDisplayMode(.inline) // Optional: adjust navigation bar title display mode
        .background(Color(.systemGray6)) // Background color
    }
}

#Preview {
    RecentTransactions()
}
