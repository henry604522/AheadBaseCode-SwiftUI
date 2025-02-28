//
//  AccStatements.swift
//  Ahead
//
//  Created by Henry MacLane on 10/29/24.
//

import SwiftUI

struct AccStatements: View {
    let months = ["October", "September", "August", "July", "June", "May", "April"]

        var body: some View {
            NavigationView {
                VStack {
                    List {
                        Section(header: Text("2024").font(.headline)) {
                            ForEach(months, id: \.self) { month in
                                NavigationLink(destination: Text("\(month) Statement Details")) {
                                    Text(month)
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())

                    Spacer()
                    
                    VStack {
                        Text("Older statements can be accessed on the web at aheadbanking.com")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 8)

                        Button(action: {
                            // Open the URL in a web browser
                            if let url = URL(string: "https://example.com") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Take me there")
                                .foregroundColor(Color("MainColor"))
                                .font(.headline)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Account Statements")
            }
        }
}

#Preview {
    AccStatements()
}
