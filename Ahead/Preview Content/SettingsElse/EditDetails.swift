//
//  EditDetails.swift
//  Ahead
//
//  Created by Henry MacLane on 11/21/24.
//

import SwiftUI

struct EditDetailsView: View {
    var body: some View {
        ZStack {
            Color.black // Set the background color to black
                .ignoresSafeArea() // Ensure the background color extends to the edges
            
            Text("Ask a parent to change your details.")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .lineLimit(2)
        }
    }
}

#Preview {
    EditDetailsView()
}

