//
//  AllowenceView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/28/24.
//

import SwiftUI

struct AllowanceView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Set background color to black

            VStack(alignment: .center) {
                // Header Section
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color("MainColor"))
                            .frame(width: 60, height: 60)
                        Image(systemName: "calendar.badge.clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 50)

                    Text("Allowance")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("My Allowance")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer().frame(height: 30)
                VStack {
                    Divider()
                        .background(Color.white)
                }
                Spacer().frame(height: 30)

                // Allowance Details Section
                VStack(spacing: 0) {
                    AllowanceDetailRow(title: "Frequency", value: "Weekly")
                    Divider().background(Color.black) // Black divider
                    AllowanceDetailRow(title: "Paid on", value: "Friday")
                    Divider().background(Color.black) // Black divider
                    AllowanceDetailRow(title: "Paid by", value: "Mom")
                    Divider().background(Color.black) // Black divider
                    AllowanceDetailRow(title: "Amount", value: "$15")
                }
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("BLACK2")))
                .padding(.horizontal)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top) // Align to the top
        }
    }
}

struct AllowanceDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("BLACK2"))
        .cornerRadius(10)
    }
}

struct AllowanceView_Previews: PreviewProvider {
    static var previews: some View {
        AllowanceView()
    }
}

