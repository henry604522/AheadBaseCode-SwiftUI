//
//  SignUpLoginView.swift
//  Ahead
//
//  Created by Henry MacLane on 9/29/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUp: View {
    @State private var fullName = ""
        @State private var email = ""
        @State private var password = ""
        @State private var birthday = Date()
        @State private var showAlert = false
        @State private var alertMessage = ""

    var body: some View {
            VStack(spacing: 20) {
                Image("LOGO")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 40)
                    .padding(.top, -50)
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .padding(.bottom, 20)

                CustomTextField(placeholder: Text("Full Name").foregroundColor(.white), text: $fullName)
                    .padding()
                    .background(Color("BLACK2"))
                    .cornerRadius(20)
                    .foregroundColor(.white)

                CustomTextField(placeholder: Text("Email").foregroundColor(.white), text: $email)
                    .padding()
                    .background(Color("BLACK2"))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)

                CustomSecureField(placeholder: Text("Password").foregroundColor(.white), text: $password)
                    .padding()
                    .background(Color("BLACK2"))
                    .cornerRadius(20)
                    .foregroundColor(.white)

                DatePicker("Birthday", selection: $birthday, displayedComponents: .date)
                    .padding()
                    .background(Color("BLACK2"))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    

                Spacer()
                Spacer()

                Button(action: signUp) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("MainColor"))
                        .cornerRadius(30)
                }
                .padding(.horizontal)

            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }

        private func signUp() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    alertMessage = error.localizedDescription
                    showAlert = true
                    return
                }
                // Optionally save the user's full name and birthday to Firestore or Realtime Database here.
            }
        }
    }

    struct CustomTextField: View {
        var placeholder: Text
        @Binding var text: String
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text)
                    .foregroundColor(.white)
            }
        }
    }

struct CustomSecureField: View {
    var placeholder: Text
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SignUp()
}





