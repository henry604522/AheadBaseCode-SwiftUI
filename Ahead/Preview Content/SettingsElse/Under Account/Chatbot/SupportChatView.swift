//
//  SupportChatView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/28/24.
//

import SwiftUI

struct SupportChatView: View {
    @State private var messages: [Message] = [Message(content: "Hey, I'm Ahead. Here to help with any questions you may have. If you're still unsatisfied after our conversation, contact our support team at support@aheadteenbanking.com. What can I help you with?", isUser: false, timestamp: Date())]
    @State private var newMessage: String = ""
    let logoImage = Image("LOGO") // Replace with your actual logo image name
    let mainBackgroundColor = Color.white // Use this to change background of page
    let userMessageBackgroundColor = Color.blue // Use this to change user message background color
    let botMessageBackgroundColor = Color.gray.opacity(0.2) // Use this to change bot message background color
    let textColor = Color.black // Use this to change text color
    let userTextColor = Color.white // Use this to change user text color
    
    var body: some View {
        VStack {
            logoImage
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 50)
                .padding(.top, 20)
            
            Text(Date(), style: .date)
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(messages) { message in
                        MessageView(message: message, messages: messages, logoImage: logoImage)
                    }
                }
            }
            .padding()
            
            HStack {
                TextField("Type a message", text: $newMessage)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
                    .frame(minHeight: CGFloat(40))
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("MainColor"))
                }
            }
            .padding()
        }
        .background(mainBackgroundColor) // Background color of the page
        .navigationBarTitle("Support", displayMode: .inline)
    }
    
    private func sendMessage() {
        let userMessage = Message(content: newMessage, isUser: true, timestamp: Date())
        messages.append(userMessage)
        newMessage = ""
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiResponse = Message(content: "This is a simulated response from AI.", isUser: false, timestamp: Date())
            messages.append(aiResponse)
        }
    }
}

struct SupportChatView_Previews: PreviewProvider {
    static var previews: some View {
        SupportChatView()
    }
}





