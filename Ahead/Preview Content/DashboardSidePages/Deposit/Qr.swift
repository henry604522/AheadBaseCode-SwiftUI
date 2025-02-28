//
//  Qr.swift
//  Ahead
//
//  Created by Henry MacLane on 10/29/24.
//
import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let username: String
}

struct QR: View {
    @State private var searchText: String = "" // Tracks what the user types
    
    let contacts = [
        Contact(name: "Trevor Smith", username: "trevorsmith1"),
        Contact(name: "Emma Johnson", username: "emmajohnson2"),
        Contact(name: "Liam Brown", username: "liambrown3"),
        Contact(name: "Sophia Davis", username: "sophiadavis4")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            HStack {
                CustomTextField(placeholder: Text("Search name or @username").foregroundColor(.gray), text: $searchText)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color("BLACK2")) // Manually set background to black
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                
                Image(systemName: "qrcode.viewfinder")
                    .foregroundColor(.white)
                    .padding(.trailing, 12)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            Divider()
                .background(Color.black)
            
            // Contacts List
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(contacts) { contact in
                        HStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.black)
                                .overlay(Text("V").foregroundColor(.gray))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(contact.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("@\(contact.username)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 16)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct QR_Previews: PreviewProvider {
    static var previews: some View {
        QR()
    }
}
