//
//  Help Center.swift
//  Ahead
//
//  Created by Henry MacLane on 1/3/25.
//


import SwiftUI

struct HelpCenterView: View {
    @State private var expandedQuestion: String?
    @State private var searchText: String = ""

    // Sample questions and answers
    let allQuestions: [(String, String)] = [
        ("Is Ahead safe for my teen?", "Yes, Ahead uses bank-level encryption and security features to protect your teen's financial data."),
        ("Can I monitor my teen's spending?", "Yes, parents can view transactions and set spending limits through the Ahead app."),
        ("How do I add money to my teen’s account?", "You can transfer funds from your linked bank account or set up direct deposit."),
        ("What happens if my teen loses their card?", "You or your teen can freeze the card instantly in the app and request a replacement."),
        ("How can I set spending limits?", "You can set daily or monthly spending limits through the app."),
        ("Can my teen receive alerts for transactions?", "Yes, both parents and teens can receive transaction alerts."),
        ("What if my teen forgets their password?", "They can reset it using the 'Forgot Password' option in the app."),
        ("Can I access my teen's account statements?", "Yes, you can view their account statements directly in the app."),
        ("How to reset my password?", "Go to settings and select 'Reset Password'."),
        ("How to update account details?", "Navigate to 'Profile' and update your details."),
        ("How to manage spending limits?", "Set limits in the account preferences."),
        ("How to lock the card?", "Use the mobile app to temporarily lock your card."),
        ("How do I report a lost card?", "Contact customer support through the app immediately."),
        ("Is there a fee for account maintenance?", "No, Ahead does not charge account maintenance fees."),
        ("How do I contact customer support?", "You can reach customer support through the app or website."),
        ("What happens if my teen's account is inactive?", "Inactive accounts may be subject to review or closure."),
        ("How do I download the Ahead app?", "The app is available for download on the App Store and Google Play."),
        ("Can I use the app on multiple devices?", "Yes, you can log in to your account from multiple devices."),
        ("How do I enable notifications?", "You can enable notifications in the app settings."),
        ("Is there a limit to how much money I can transfer?", "There are daily transfer limits; check the app for details."),
        ("Can I use Ahead for international transactions?", "Currently, Ahead only supports domestic transactions."),
        ("How do I view transaction history?", "You can view transaction history in the 'Transactions' section of the app."),
        ("What if I have issues with the app?", "Restart the app or contact support for assistance."),
        ("Is my personal information secure?", "Yes, Ahead uses advanced security measures to protect your data.")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("Help Center")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 40)
                .padding(.horizontal)
            
            // More space under title
            Spacer().frame(height: 15)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search FAQs...", text: $searchText)
                    .foregroundColor(.white)
                    .onTapGesture {
                        // Pull up the keyboard when tapped
                        UIApplication.shared.beginEditing()
                    }
            }
            .padding(10)
            .background(Color.white.opacity(0.2))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            // Space before FAQs
            Spacer().frame(height: 20)
            
            // FAQ Sections
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    FAQSection(title: "Parents' Questions", questions: filterQuestions(for: "Parents' Questions"), expandedQuestion: $expandedQuestion)
                    FAQSection(title: "Account & Security", questions: filterQuestions(for: "Account & Security"), expandedQuestion: $expandedQuestion)
                    FAQSection(title: "App Features", questions: filterQuestions(for: "App Features"), expandedQuestion: $expandedQuestion)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func filterQuestions(for section: String) -> [(String, String)] {
        // Filter questions based on the search text
        let sectionQuestions: [String: [(String, String)]] = [
            "Parents' Questions": [
                ("Is Ahead safe for my teen?", "Yes, Ahead uses bank-level encryption and security features to protect your teen's financial data."),
                ("Can I monitor my teen's spending?", "Yes, parents can view transactions and set spending limits through the Ahead app."),
                ("How do I add money to my teen’s account?", "You can transfer funds from your linked bank account or set up direct deposit."),
                ("What happens if my teen loses their card?", "You or your teen can freeze the card instantly in the app and request a replacement.")
            ],
            "Account & Security": [
                ("How to reset my password?", "Go to settings and select 'Reset Password'."),
                ("How to update account details?", "Navigate to 'Profile' and update your details."),
                ("How to manage spending limits?", "Set limits in the account preferences."),
                ("How to lock the card?", "Use the mobile app to temporarily lock your card."),
                ("What if my teen forgets their password?", "They can reset it using the 'Forgot Password' option in the app."),
                ("Is there a fee for account maintenance?", "No, Ahead does not charge account maintenance fees."),
                ("Can I access my teen's account statements?", "Yes, you can view their account statements directly in the app.")
            ],
            "App Features": [
                ("Can my teen receive alerts for transactions?", "Yes, both parents and teens can receive transaction alerts."),
                ("How do I contact customer support?", "You can reach customer support through the app or website."),
                ("What happens if my teen's account is inactive?", "Inactive accounts may be subject to review or closure."),
                ("How do I download the Ahead app?", "The app is available for download on the App Store and Google Play."),
                ("Can I use the app on multiple devices?", "Yes, you can log in to your account from multiple devices."),
                ("How do I enable notifications?", "You can enable notifications in the app settings."),
                ("Can I use Ahead for international transactions?", "Currently, Ahead only supports domestic transactions."),
                ("How do I view transaction history?", "You can view transaction history in the 'Transactions' section of the app.")
            ]
        ]

        guard let questions = sectionQuestions[section] else { return [] }
        
        // Filter the questions based on the search text
        if searchText.isEmpty {
            return questions
        } else {
            return questions.filter { question, _ in
                question.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct FAQSection: View {
    let title: String
    let questions: [(String, String)]
    @Binding var expandedQuestion: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical, 10) // Increased padding around subtitles

            ForEach(questions, id: \.0) { question, answer in
                FAQRow(question: question, answer: answer, expandedQuestion: $expandedQuestion)
            }
        }
    }
}

struct FAQRow: View {
    let question: String
    let answer: String
    @Binding var expandedQuestion: String?

    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    expandedQuestion = expandedQuestion == question ? nil : question
                }
            }) {
                HStack {
                    Text(question)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: expandedQuestion == question ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .frame(height: 60) // Set a fixed height for consistency
            }

            if expandedQuestion == question {
                Text(answer)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("BLACK2")) // Custom background color
                    .cornerRadius(15)
                    .transition(.opacity)
                    .padding(.top, -5) // Remove space between question and answer
            }
        }
    }
}

extension UIApplication {
    func beginEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    HelpCenterView()
}






