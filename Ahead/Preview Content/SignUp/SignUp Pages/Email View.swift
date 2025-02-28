//
//  Email View.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct EmailView: View {
    @State private var email = ""

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: DateOfBirthView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 2, total: 6)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("MainColor")))
                    .frame(height: 10) // Adjust the height as needed
                    .padding(.trailing)
                
                Image("SSL")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                Text("Enter your ")
                    .foregroundColor(.white) +
                Text("email")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: PasswordView()) {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}

