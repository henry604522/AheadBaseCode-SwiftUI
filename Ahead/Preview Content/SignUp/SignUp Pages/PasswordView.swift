//
//  PasswordView.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct PasswordView: View {
    @State private var password = ""

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: EmailView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 3, total: 6)
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
                Text("Create a ")
                    .foregroundColor(.white) +
                Text("password")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()

            CustomSecureField(placeholder: Text("Password").foregroundColor(.gray), text: $password)
                .padding()
                .background(Color("BLACK2"))
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: VerifyEmailView()) {
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

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
    }
}

