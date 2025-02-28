//
//  Wallet.swift
//  Ahead
//
//  Created by Henry MacLane on 10/1/24.
//
import SwiftUI
struct Wallet: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                ScrollView {
                    VStack {
                        BalanceView()
                            .padding(.top, 20)
                            .padding(.horizontal, -20)

                        ZStack {
                            BalanceViewCard()
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 50)
                       
                        VStack(alignment: .leading) {
                            Text("Options")
                                .font(.headline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.white)
                        }
                        .padding(.leading, -175)
                        .padding(.bottom, -5)
                        
                        ZStack{
                            BottomThing()
                        }
                        .padding(.horizontal, 5)
                    }
                }

                Spacer()
            }
        }
    }
}

struct Wallet_Previews: PreviewProvider {
    static var previews: some View {
        Wallet()
    }
}

struct DebitCardView: View {
    var body: some View {
        ZStack {
            // Card Background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("MainColor"))
                .frame(width: 350, height: 220)
                .shadow(radius: 0)
            
            VStack(alignment: .leading) {
                HStack {
                    // Card
                    Image("LOGO2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 75)
                        .padding()
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Debit")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 15)
          
                HStack {
                    // Dots for card number
                    Text("••••")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Text("8956")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Mastercard logo imitation
                    HStack(spacing: -10) {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 40, height: 40)
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .padding()
            .padding(.horizontal, 25)
            .padding(.bottom, 0)
        }
    }
}

struct BottomThing: View {
    @State private var isCardLocked = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Card Settings
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(Color.white)
                
                Text(isCardLocked ? "Unlock Card" : "Lock Card")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Toggle("", isOn: $isCardLocked)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color("MainColor")))
            }
            .padding()
            
            VStack {
                Divider()
                    .background(Color.black)
            }
            
            HStack {
                Image(systemName: "applelogo")
                    .foregroundColor(Color.white)
                
                Text("Add Card to Apple Pay")
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
            
            VStack {
                Divider()
                    .background(Color.black)
            }
            
            NavigationLink(destination: Credit()) {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Manage Credit Score")
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
            }

            VStack {
                Divider()
                    .background(Color.black)
            }
            
            NavigationLink(destination: OrderCardView()) {
                HStack {
                    Image(systemName: "arrow.2.squarepath")
                        .foregroundColor(Color.white)
                    
                    Text("Replace Card")
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding()
            }
            
                    }
        .background(Color("BLACK2"))
        .cornerRadius(15)
        .padding()
    }
}

struct BalanceViewCard: View {
    var body: some View {
        NavigationLink(destination: OrderCardView()) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 75)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Next Credit Bill")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.caption)
                            Text("$44.92")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                    }
                        .padding()
                )
                .padding()
        }
    }
}

struct AutopayIsOn: View {
    @State private var AutopayIsOn = true
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            showAlert = true
        }) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 75)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Autopay Bills")
                                .lineLimit(2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white.opacity(0.5))
                                .font(.title2)
                            Text("This setting will autopay all of your credit bills.")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray.opacity(0.5))
                                .font(.caption)
                        }
                        Spacer()
                        
                        Toggle("", isOn: $AutopayIsOn)
                            .labelsHidden()
                            .toggleStyle(SwitchToggleStyle(tint: Color("MainColor")))
                            .disabled(true)
                    }
                    .padding()
                )
                .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Default Setting"),
                  message: Text("This setting is defaulted to 'on' the first three months after you sign up. To toggle off in the future, build trust by spending wisely and keeping card information safe."),
                  dismissButton: .default(Text("Close")))
        }
    }
}



