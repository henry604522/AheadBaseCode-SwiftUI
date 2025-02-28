//
//  AccLimits.swift
//  Ahead
//
//  Created by Henry MacLane on 10/29/24.
//

import SwiftUI

struct AccLimits: View {
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Spacer()
                Text("Limits")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            // Lock Icon and Title
            VStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                
                Text("Access higher limits")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("You can get higher limits and access other features asking a parent.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            // Buttons
            HStack(spacing: 16) {
                Button(action: {
                    // Action for Learn More
                }) {
                    Text("Learn more")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // Action for Ask Parent
                }) {
                    Text("Ask parent")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            // Cash Limits
            VStack(alignment: .leading, spacing: 16) {
                Text("CASH LIMITS")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Send")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        Text("$1,000 per Month\n$1,500 total")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Receive")
                            .font(.body)
                            .fontWeight(.semibold)
                        
                        Text("$1,000 per Month\n$1,500 total")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                HStack {
                    Text("Cash Balance")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                    Text("$1,000")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AccLimits()
}
