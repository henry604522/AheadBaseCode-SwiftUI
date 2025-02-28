//
//  AheadApp.swift
//  Ahead
//
//  Created by Henry MacLane on 9/29/24.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct AheadApp: App {
   // Register app delegate for Firebase setup
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

   var body: some Scene {
       WindowGroup {
           NavigationView {
               SignInView()
           }
       }
   }
}

// Create a single AppDelegate class for Firebase configuration
class AppDelegate: NSObject, UIApplicationDelegate {
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // Configure Firebase
       FirebaseApp.configure()
       return true
   }
}







/*
 
This is where I put everything I need to fix/update
 
 
 Steps:
 
 Oct 26-27
 Code the Notifications Page
 Also Code the learn page and daily trivia
 Finish the powerpoint on the 26th
 
 28-31st
 Work on the Settings page and add the final touches to the card page.
 make sure to add a screen where the user can order there card
 add functionality to the buttons on credit page
 
 1st-3rd
 final touches/tweaks
 
 
 
 
 
 
 SplashScreen:
 Fix the colors on app logo
 
SignUp/Login:
 add button fuctions and change the text and Icon and make it look more proffesional
 
 
 MultiStepTeenSignUp:
 
Remove the apple integrated back button and make the text more ptofessional, add the functionality for the parents and add email verification and make sure the user is 12 or over.Add features to the design and improve the overall quality. make sure the data is saved in firebase.
 
 implement checks like verifications and everything
 
 on the select birthday page if the user selects there birthday to be in the future then add the text "You were born in the future? I guess that gives you plenty of time to tell us your real age." and if they are over 25 have it say "Little old for this app huh (crying/laugh emoji)"
 
 Dashboard:
 add a manage my card section underneath the data but above the chart (greenlight app dashboard). Make it colorful and professional
 
 Invest Page:
 fix chart and transaction and make it functional
 
 Learn Page:
 add color to the page and fix the search stocks, make the links clickable
 */


