//
//  Kid Page.swift
//  Ahead
//
//  Created by Henry MacLane on 1/3/25.
//

import SwiftUI

struct ChildAccountView: View {
    @State private var isCardLocked = false

    var body: some View {
        ZStack {
            // Background Semi-Circle
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    path.addArc(
                        center: CGPoint(x: width / 2, y: 0),
                        radius: width / 1.1,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: false
                    )
                }
                .fill(Color("MainColor"))
                .ignoresSafeArea()
            }

            // Content
            VStack(spacing: 20) {
                // Back Button and Pay Button
                HStack {
                    Button(action: {
                        // Back button action
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 25, height: 20)
                    }
                    Spacer()
                    Button(action: {
                        // Pay action
                    }) {
                        Text("Pay")
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .foregroundColor(Color("MainColor"))
                            .cornerRadius(30)
                    }
                }
                .padding()

                // Profile Section
                VStack {
                    // Profile Picture
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 10)
                    // Name
                    Text("Henry Maclane")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .bold()
                          
                    Text("Age 13")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                }
                .padding(.bottom, 70)

                
               
                

                // Account Summary Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Balance")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("$249.81")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    Divider().background(Color.white)
                    HStack {
                        Text("Total Savings")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("$81.64")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    Divider().background(Color.white)
                    HStack {
                        Text("Credit Score")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("N/A")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    Divider().background(Color.white)
                    HStack {
                        Text("Allowance")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("$10/w")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                }
                .padding()
                .background(Color("BLACK2"))
                .cornerRadius(15)

                VStack {
                    Text("Quick Options")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, -175)
                .padding(.top)
                .padding(.bottom, -10)

                // Quick Options Section
                VStack(alignment: .leading, spacing: 10) {
                    // Lock Card Toggle
                    HStack {
                        Text("Lock Card")
                            .foregroundColor(Color.white)
                        Spacer()
                        Toggle("", isOn: $isCardLocked)
                            .labelsHidden()
                    }
                    Divider().background(Color.white)

                    // Set Limits Button
                    HStack {
                        Text("Set Limits")
                            .foregroundColor(Color.white)
                        Spacer()
                        Button(action: {
                            // Set limits action
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                        }
                    }
                    Divider().background(Color.white)

                    // Manage Allowance Button
                    HStack {
                        Text("Manage Allowance")
                            .foregroundColor(Color.white)
                        Spacer()
                        Button(action: {
                            // Manage allowance action
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding()
                .background(Color("BLACK2"))
                .cornerRadius(15)

                Spacer()
            }
            .padding()
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct ChildAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ChildAccountView()
    }
}
