//
//  ToDo.swift
//  Ahead
//
//  Created by Henry MacLane on 10/7/24.
//

import SwiftUI

struct ToDo: View {
    @State private var showAccountTasks = false
    @State private var showCardTasks = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("TO-DO")
                .font(.largeTitle)
                .bold()
                .padding()
            
            // Task 1: Finish Account Setup
            VStack(alignment: .leading) {
                HStack {
                    Text("Finish account setup")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showAccountTasks.toggle()
                        }
                    }) {
                        Image(systemName: showAccountTasks ? "chevron.up" : "chevron.down")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                if showAccountTasks {
                    Text("1 Task")
                        .padding(.leading)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 0) {
                // Rounded rectangle with the "Get your cards" text and icon
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 60) // Set height for the rounded rectangle

                    HStack {
                        Image(systemName: "creditcard")
                            .foregroundColor(.black) // Set icon color
                        Text("Get your cards")
                            .font(.headline)
                            .foregroundColor(.black) // Set text color
                        Spacer()
                    }
                    .padding(.horizontal)
                }

                // Thin black line separating the rounded rectangle and the dropdown
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1) // Set height for the line

                // Dropdown section
                HStack {
                    Text("Get your cards")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showCardTasks.toggle()
                        }
                    }) {
                        Image(systemName: showCardTasks ? "chevron.up" : "chevron.down")
                    }
                }
                .padding()
                .background(Color.clear) // Make the dropdown background clear
                .cornerRadius(10)
                
                if showCardTasks {
                    Text("4 Tasks")
                        .padding(.leading)
                }
            }
            .padding(.horizontal)

            
            VStack(alignment: .leading) {
                HStack {
                    Text("Get your cards")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showCardTasks.toggle()
                        }
                    }) {
                        Image(systemName: showCardTasks ? "chevron.up" : "chevron.down")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                if showCardTasks {
                    Text("4 Tasks")
                        .padding(.leading)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
#Preview {
    ToDo()
}
