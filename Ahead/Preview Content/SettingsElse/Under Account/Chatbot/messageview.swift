//
//  messageview.swift
//  Ahead
//
//  Created by Henry MacLane on 10/28/24.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var messages: [Message] // Add this line to receive the messages array
    var logoImage: Image
    
    var body: some View {
        HStack(alignment: .top) {
            if message.isUser {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .padding()
                        .background(Color.blue) // User message background color
                        .foregroundColor(.white) // User text color
                        .cornerRadius(10)
                        .frame(maxWidth: 250, alignment: .trailing)
                    if isMostRecentMessage(message) {
                        Text("just now")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        logoImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(message.content)
                                .padding()
                                .background(Color.gray.opacity(0.2)) // Bot message background color
                                .foregroundColor(.black) // Text color
                                .cornerRadius(10)
                                .frame(maxWidth: 250, alignment: .leading)
                        }
                    }
                    if isMostRecentMessage(message) {
                        HStack {
                            Text("Ahead")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("just now")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(message.isUser ? .leading : .trailing, 50)
        .padding(.vertical, 5)
    }
    
    private func isMostRecentMessage(_ message: Message) -> Bool {
        // Determine if the message is the most recent one
        guard let lastMessage = messages.last else { return false }
        return message.id == lastMessage.id
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(content: "Hello", isUser: true, timestamp: Date()), messages: [Message(content: "Hello", isUser: true, timestamp: Date())], logoImage: Image("LOGO"))
    }
}





