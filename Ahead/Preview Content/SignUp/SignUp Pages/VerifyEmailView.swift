//
//  VerifyEmailView.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct VerifyEmailView: View {
    @State private var verificationCode = ""

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: PasswordView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 4, total: 6)
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
                Text("Verify your ")
                    .foregroundColor(.white) +
                Text("email")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()
            .padding(.bottom)

            CustomTextField(placeholder: Text("Verification Code").foregroundColor(.gray), text: $verificationCode)
                .padding()
                .background(Color("BLACK2"))
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: PhoneNumberView()) {
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

struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}
