//
//  SplashScreen.swift
//  Ahead
//
//  Created by Henry MacLane on 9/29/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            SignInView()
                .opacity(isActive ? 1 : 0) // Keep the opacity change without animation
            
            if !isActive {
                Color("MainColor")
                    .edgesIgnoringSafeArea(.all)
                Image("LOGO2") // Logo for app
                    .resizable()
                    .frame(width: 200, height: 200)
                    .onAppear {
                        // Set isActive after a delay without animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isActive = true
                        }
                    }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}


