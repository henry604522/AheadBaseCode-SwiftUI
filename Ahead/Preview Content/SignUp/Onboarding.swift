//
//  Onboarding.swift
//  Ahead
//
//  Created by Henry MacLane on 11/30/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    
    let onboardingData = [
        OnboardingData(imageName: "slide1Image", title: "Welcome to Ahead!", description: "At Ahead, were preparing Teens for the life Ahead of them. Our app helps you navigate through your financial journey with ease and confidence. Get ready to take control of your financial future."),
        OnboardingData(imageName: "slide2Image", title: "Build Credit", description: "Build credit and manage your finances effectively. With our tools, you can establish a solid credit history and learn to make informed financial decisions."),
        OnboardingData(imageName: "slide3Image", title: "Own a Debit Card", description: "Own a debit card and learn to save wisely. Our app provides you with the resources to manage your spending and save for the future."),
        OnboardingData(imageName: "slide4Image", title: "Learn and Grow", description: "Gain financial knowledge and make informed decisions. Our educational resources help you understand personal finance and grow your wealth.")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    // Action to exit onboarding
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            
            HStack {
                ForEach(0..<onboardingData.count) { index in
                    Circle()
                        .fill(index == currentIndex ? Color("MainColor") : Color.white)
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 10)
            
            Spacer()
            
            TabView(selection: $currentIndex) {
                ForEach(onboardingData.indices, id: \.self) { index in
                    OnboardingScreen(data: onboardingData[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
            
            VStack {
                Button(action: {
                    if currentIndex < onboardingData.count - 1 {
                        currentIndex += 1
                    } else {
                        // Action to finish onboarding
                    }
                }) {
                    Text(currentIndex == onboardingData.count - 1 ? "Finish" : "Continue")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                        .padding(.top, 125)
                }
                
                if currentIndex == 0 {
                    Button(action: {
                        // Action to skip onboarding
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("BLACK2"))
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                } else if currentIndex > 0 {
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Text("Back")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("BLACK2"))
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct OnboardingScreen: View {
    let data: OnboardingData
    
    var body: some View {
        VStack {
            Image(data.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding()
            
            Text(data.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
                .padding(.bottom)
            
            Text(data.description)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
        }
    }
}

struct OnboardingData {
    let imageName: String
    let title: String
    let description: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}


