//
//  PhoneNumberView.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct PhoneNumberView: View {
    @State private var phoneNumber = ""

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: VerifyEmailView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 5, total: 6)
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
                Text("phone number")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()

            CustomTextField(placeholder: Text("Phone Number").foregroundColor(.white), text: $phoneNumber)
                .padding()
                .background(Color("BLACK2"))
                .foregroundStyle(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: ProfilePictureView()) {
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

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}



