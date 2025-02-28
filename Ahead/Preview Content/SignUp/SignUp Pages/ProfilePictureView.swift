//
//  ProfilePictureView.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct ProfilePictureView: View {
    @State private var profileImage: Image? = nil
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: PhoneNumberView()) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 6, total: 6)
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
                Text("Choose a ")
                    .foregroundColor(.white) +
                Text("profile picture")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()

            if let profileImage = profileImage {
                profileImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .padding()
            }

            Button(action: {
        
            }) {
                Text("Select Image")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding()
            }
            
            Spacer()

            NavigationLink(destination: SummaryView()) {
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

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }
}

struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView()
    }
}
