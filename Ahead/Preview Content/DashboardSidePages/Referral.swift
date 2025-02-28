//
//  Referral.swift
//  Ahead
//
//  Created by Henry MacLane on 10/21/24.
//

import SwiftUI

struct InviteFriendsView: View {
    var body: some View {
        ZStack {
            // Set background color to black
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Top exit button
                HStack {
                    Button(action: {
                        // Close action
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                // Main content
                Image(systemName: "person.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("MainColor"))
                
                Text("Invite Friends and Get\n$5 Each")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top)
                
                Text("Receive $5 for each friend you refer!")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 350)
                
                // Buttons
                VStack(spacing: 10) {
                    Button(action: {
                        // Allow & Continue action
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("MainColor"))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // See Terms button
                Button(action: {
                    // See Terms action
                }) {
                    Text("See Terms")
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding(.top)
                
                Spacer()
            }
        }
    }
}

struct InviteFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        InviteFriendsView()
    }
}

