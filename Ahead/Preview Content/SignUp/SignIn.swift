//
//  SignIn.swift
//  Ahead
//
//  Created by Henry MacLane on 10/3/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import LocalAuthentication

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var showFaceIDOption: Bool = false
    @State private var isPasswordVisible: Bool = false // State to toggle password visibility
    
    var body: some View {
        NavigationView {
            VStack {
                // Sign In text styled larger and professional
                Text("Log In")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                    .padding(.bottom, 80)
                    .padding(.top, -10)
                
                
               

                VStack(spacing: 15) {
                    CustomTextField(placeholder: Text("Email").foregroundColor(.white), text: $email)
                        .padding()
                        .frame(height: 50)
                        .background(Color("BLACK2"))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                        .autocapitalization(.none)
                        .padding(.horizontal)
                        .padding(.bottom, 1)
                        .font(.system(size: 14)) // Adjust font size
                        .foregroundColor(.white) // Set text color to black
                    
                    
                    // Password field with visibility toggle button
                    ZStack {
                        if isPasswordVisible {
                            CustomTextField(placeholder: Text("Password").foregroundColor(.white), text: $password)
                                .padding()
                                .frame(height: 50)
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                                .padding(.horizontal)
                                .font(.system(size: 14)) // Adjust font size
                                .foregroundColor(.white) // Set text color to black
                        } else {
                            CustomSecureField(placeholder: Text("Password").foregroundColor(.white), text: $password)
                                .padding()
                                .frame(height: 50)
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                                .padding(.horizontal)
                                .font(.system(size: 14)) // Adjust font size
                                .foregroundColor(.white) // Set text color to black
                        }
                        // Button to toggle password visibility
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 10)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 30)
                            }
                        }
                    }
                    
                    // Forgot Password button centered
                    Button(action: {
                        // Forgot password action
                    }) {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .foregroundColor(Color("MainColor"))
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
                // Sign In button at the bottom
                VStack {
                    Button(action: signIn) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(isFormValid ? Color("MainColor") : Color("BLACK2"))
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 20)
                    .disabled(!isFormValid) // Disable button if form is not valid
                    
                    // "Don't have an account?" button
                    NavigationLink(destination: DateOfBirthView()) {
                        Text("Don't have an Account?")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 40)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Page background color
            .onAppear(perform: checkForBiometrics)
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigate(to: DashboardView(), when: $isSignedIn) // Custom navigate view modifier
        }
    }
    
    // Function to handle Face ID authentication
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID to sign in."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    DispatchQueue.main.async {
                        isSignedIn = true // Navigate to DashboardView if Face ID succeeds
                    }
                } else {
                    DispatchQueue.main.async {
                        showError = true
                        errorMessage = authenticationError?.localizedDescription ?? "Face ID failed."
                    }
                }
            }
        } else {
            showError = true
            errorMessage = "Face ID not available."
        }
    }
    
    // Check if Face ID is available and set the flag to show the Face ID button
    private func checkForBiometrics() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            showFaceIDOption = true
        }
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                showError = true
                errorMessage = error.localizedDescription
                return
            }
            isSignedIn = true // Navigate to DashboardView if sign-in is successful
        }
    }
    
    // Computed property to check if both email and password fields are filled in
    private var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
}

// Custom ViewModifier for navigation
struct NavigateModifier<Destination: View>: ViewModifier {
    var destination: Destination
    @Binding var isActive: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            NavigationLink(destination: destination, isActive: $isActive) {
                EmptyView()
            }
        }
    }
}

extension View {
    func navigate<Destination: View>(to destination: Destination, when binding: Binding<Bool>) -> some View {
        self.modifier(NavigateModifier(destination: destination, isActive: binding))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



