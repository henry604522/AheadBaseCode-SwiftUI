//
//  Setting.swift
//  Ahead
//
//  Created by Henry MacLane on 10/6/24.
//

import SwiftUI
import UIKit
import FirebaseAuth

struct Settings: View {
    @State private var isSignedOut = false
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Profile Info Section
                    VStack(spacing: 16) {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .resizable()
                                                   .scaledToFill()
                                                   .frame(width: 80, height: 80)
                                                   .clipShape(Circle())
                                                   .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                           } else {
                                               Circle()
                                                   .fill(Color.gray)
                                                   .frame(width: 80, height: 80)
                                                   .overlay(
                                                       Image(systemName: "camera.on.rectangle.fill")
                                                           .resizable()
                                                           .scaledToFit()
                                                           .frame(width: 25, height: 25)
                                                           .foregroundColor(.white)
                                                           .padding()
                                                   )
                                                   .onTapGesture {
                                                       showingImagePicker = true
                                                   }
                                           }
                                           Text("Henry MacLane")
                                               .font(.title2)
                                               .foregroundColor(Color.white)
                                               .bold()
                                               .padding(.bottom)
                                       }
                                       .actionSheet(isPresented: $showingImagePicker) {
                                           ActionSheet(title: Text("Select Image"), message: nil, buttons: [
                                               .default(Text("Photo Library")) {
                                                   sourceType = .photoLibrary
                                                   showingImagePicker = true
                                               },
                                               .default(Text("Camera")) {
                                                   sourceType = .camera
                                                   showingImagePicker = true
                                               },
                                               .cancel()
                                           ])
                                       }
                                       .sheet(isPresented: $showingImagePicker) {
                                           ImagePickerSavings(image: $selectedImage)
                        
                        // Get Sponsored Section
                        NavigationLink(destination: CompleteSignUp()) {
                            HStack {
                                Image(systemName: "message.badge.fill")
                                    .foregroundColor(Color("MainColor"))
                                    .font(.largeTitle)
                                VStack(alignment: .leading) {
                                    Text("Complete Sign Up")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text("Ask an adult to complete your sign up")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                    
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .padding(.top, 0)
                            .background(Color("BLACK2"))
                            .cornerRadius(20)
                        }
                        .padding(.top, -70)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        // Details text aligned with the rectangle
                        HStack {
                            Text("Personal Details")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.top)
                                .padding(.leading, 15) // Align with the left padding of the rectangle
                                .padding(.bottom, 5)
                            
                            Spacer()
                            
                            NavigationLink(destination: EditDetailsView()){
                                ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color("MainColor"))
                                    .frame(width: 50, height: 25)

                                Text("Edit")
                                    .scaledToFit()
                                    .font(.caption)
                                    .foregroundStyle(Color.white)
                                    .lineLimit(1)
                                    .padding(.horizontal, 10)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                               }
                                .padding(.trailing, -125)
                                .padding(.bottom, -5)
                            }
                        }

                        // Rounded Rectangle Container
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("BLACK2"))
                                .shadow(radius: 1)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Name")
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Text("Henry MacLane")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                
                                Divider().background(Color.black) // Thin black line
                                
                                HStack {
                                    Text("Birthday")
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Text("03/04/2011")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                
                                Divider().background(Color.black) // Thin black line
                                
                                HStack {
                                    Text("Phone")
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Text("(615) 982-2164")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                
                                Divider().background(Color.black) // Thin black line
                                
                                HStack {
                                    Text("Email")
                                        .foregroundStyle(Color.white)
                                    Spacer()
                                    Text("h************@gmail.com")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                        }
                        .padding(.horizontal) // Ensure padding around the entire rectangle

                        
                        Spacer(minLength: 20) // Add some space above the button group
                        
                        Text("Account")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.top)
                            .padding(.leading, 16) // Align with the left padding of the rectangle

                        // Button Group
                        VStack(spacing: 1) { // Set spacing to 1 to create a line-like separator
                            
                            NavigationLink(destination: Deposit()) {
                                HStack {
                                    createCircleIcon(systemImage: "creditcard")
                                    Text("Withdraw")
                                        .foregroundColor(.white) // Change text color to white
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10) // Round edges of the button
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: AccStatements()) {
                                HStack {
                                    createCircleIcon(systemImage: "document")
                                    Text("Credit Statements")
                                        .foregroundColor(.white) // Change text color to white
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10) // Round edges of the button
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: Wallet()) {
                                HStack {
                                    createCircleIcon(systemImage: "creditcard")
                                    Text("Manage Card")
                                        .foregroundColor(.white) // Change text color to white
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10) // Round edges of the button
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: AccLimits()) {
                                HStack {
                                    createCircleIcon(systemImage: "light.beacon.max")
                                    Text("Limits")
                                        .foregroundColor(.white) // Change text color to white
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10) // Round edges of the button
                            }
                            
                            Divider().background(Color.black)
                            
                            // Add new buttons below
                            NavigationLink(destination: ChildAccountView()) {
                                HStack {
                                    createCircleIcon(systemImage: "figure.and.child.holdinghands") // Icon for Family
                                    Text("Family")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10)
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: AllowanceView()) {
                                HStack {
                                    createCircleIcon(systemImage: "dollarsign") // Icon for Allowance
                                    Text("Allowance")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10)
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: Notifications()) {
                                HStack {
                                    createCircleIcon(systemImage: "bell") // Icon for Notifications
                                    Text("Notifications")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10)
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: InviteFriendsView()) {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color("MainColor")) // Fill with MainColor
                                            .frame(width: 25, height: 25)
                                        Image(systemName: "person.2")
                                            .font(.system(size: 12)) // Smaller icon size
                                            .foregroundColor(.white)
                                    }
                                    Text("Invite Friend")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10)
                            }

                            Divider().background(Color.black)

                            NavigationLink(destination: SupportChatView()) {
                                HStack {
                                    createCircleIcon(systemImage: "questionmark") // Icon for Support
                                    Text("Support")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.white)
                                }
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(10)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black))
                        .padding()
                        
                        // Center the Sign Out button
                        Button(action: {
                            signOut()
                        }) {
                            Text("Sign Out")
                                .foregroundColor(Color(.red))
                                .padding()
                                .background(Color.clear)
                        }
                        .frame(maxWidth: .infinity) // Make the button take full width
                        .padding(.bottom) // Padding at the bottom
                        .navigationBarHidden(true) // Hide navigation bar if needed
                        .fullScreenCover(isPresented: $isSignedOut) {
                            SignInView()}
                        
                        VStack(spacing: 10) {
                            // Shield Icon and FDIC-Insured Information
                            VStack(spacing: 5) {
                                Image(systemName: "checkmark.shield")
                                    .font(.system(size: 40))
                                    .foregroundColor(Color("MainColor"))
                         
                                Text("Your balance is FDIC-insured through our partner bank, Example, for up to $250,000 per person.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            
                            // Privacy Notice, Terms of Service
                            VStack(spacing: 5) {
                                HStack {
                                    Link(destination: URL(string: "https://example.com/privacy")!) {
                                        Text("Privacy Policy")
                                            .underline()
                                            .foregroundColor(Color.white)
                                    }

                                    Link(destination: URL(string: "https://example.com/terms")!) {
                                        Text("Terms of Service")
                                            .underline()
                                            .foregroundColor(Color.white)
                                    }
                                }
                                .font(.system(size: 14))
                                .padding(.bottom, 1)
                            }
                            
                            // Social Media Icons
                            HStack(spacing: 20) {
                                Image("Insta")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                Image("TikTok")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                Image("YT")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                            }
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                            .padding()
                            
                            // Version
                            Text("Version 1.01")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom, -30)

                    }
                }
                .padding(.bottom, 20) // Padding at the bottom to avoid overlap with the safe area
            }
            .background(Color.black) // Set background color
            .navigationViewStyle(StackNavigationViewStyle()) // Ensures good behavior on iPad
        }
        .edgesIgnoringSafeArea(.bottom) // Ignore safe area at the bottom
    }
    
    private func signOut() {
         do {
             try Auth.auth().signOut()
             isSignedOut = true
         } catch let signOutError as NSError {
             print("Error signing out: %@", signOutError)
         }
     }
    
    private func createCircleIcon(systemImage: String) -> some View {
        ZStack {
            Circle()
                .fill(Color("MainColor")) // Fill with MainColor
                .frame(width: 25, height: 25)
            Image(systemName: systemImage)
                .font(.system(size: 15)) // Smaller icon size
                .foregroundColor(.white)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}



