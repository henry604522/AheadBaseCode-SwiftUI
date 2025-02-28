//
//  OrderCardView.swift
//  Ahead
//
//  Created by Henry MacLane on 11/21/24.
//

import SwiftUI

struct OrderCardView: View {
    @State private var showOrderScreen = false
    @State private var selectedCard: String? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    Text("Order Card")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.bottom, 10)

                    VStack(spacing: 20) {
                        // Blue Card
                        VStack {
                            HStack {
                                Text("Blue Card")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$5")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)

                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("MainColor")) // MainColor
                                .frame(height: 200)
                                .overlay(
                                    VStack {
                                        HStack {
                                            Image("LOGO2")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        Spacer()
                                        HStack {
                                            Text("Henry MacLane")
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                )
                                .onTapGesture {
                                    selectedCard = "Blue"
                                    showOrderScreen = true
                                }
                        }

                        // White Card
                        VStack {
                            HStack {
                                Text("White Card")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$5")
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal)

                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .frame(height: 200)
                                .overlay(
                                    VStack {
                                        HStack {
                                            Image("LOGO")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        Spacer()
                                        HStack {
                                            Text("Henry MacLane")
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                )
                                .onTapGesture {
                                    selectedCard = "White"
                                    showOrderScreen = true
                                }
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $showOrderScreen) {
                    OrderScreenView(selectedCard: selectedCard)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct OrderScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    var selectedCard: String?

    @State private var rotation: Double = 0
    @State private var flip: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Text("Ordering Card")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom, 10)

                        Spacer(minLength: 50)

                        NavigationLink(destination: Wallet()) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }

                    VStack(alignment: .leading) {
                        // Card Animation Section
                        RoundedRectangle(cornerRadius: 25)
                            .fill(selectedCard == "Blue" ? Color("MainColor") : Color.white)
                            .frame(height: 200)
                            .overlay(
                                ZStack {
                                    VStack {
                                        HStack {
                                            Image(selectedCard == "Blue" ? "LOGO2" : "LOGO")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        Spacer()
                                        HStack {
                                            Text("Henry MacLane")
                                                .foregroundColor(selectedCard == "Blue" ? .white : .black)
                                            Spacer()
                                        }
                                        .padding()
                                    }

                                    if flip {
                                        VStack(alignment: .leading) {
                                            Text("4000 1234 5678 9010")
                                            Text("CVV: 123")
                                            Text("EXP: 11/27")
                                            Text("Card issued by Ahead App")
                                                .font(.caption)
                                                .padding(.top)
                                        }
                                        .padding()
                                        .foregroundColor(selectedCard == "Blue" ? .white : .black)
                                    }
                                }
                            )
                            .rotation3DEffect(
                                .degrees(rotation),
                                axis: (x: 0, y: 1, z: 0)
                            )
                            .onTapGesture {
                                withAnimation {
                                    rotation += 180
                                    flip.toggle()
                                }
                            }
                            .padding(.top, 50)

                        // Card Description
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(selectedCard  ?? "") Card")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, -5)
                            Text("Generic and simple, perfect for everyday use.")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .padding(.top, 20)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
            }
            
            // Spacer to push the "Order Card" button to the bottom
            Spacer()

            // "Order Card" button outside of the ScrollView
            ZStack {
                Button(action: {
                    // Order card action
                }) {
                    Text("Order Card")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("MainColor"))
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
        })
    }
}



#Preview {
    OrderCardView()
}
