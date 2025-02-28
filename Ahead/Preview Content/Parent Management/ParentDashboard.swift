//
//  SwiftUIView.swift
//  Ahead
//
//  Created by Henry MacLane on 11/8/24.
//

import SwiftUI

struct ParentDashboardView: View {
    @State private var selectedTipIndex: Int? = nil

    var body: some View {
        VStack(spacing: 20) {
            // Top Greeting Section
            HStack {
                Text("Hi, Michael")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
            
            }
            .padding()
            
            
            HStack {
                Text("My Kids")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Spacer()
                
                Button(action: {
                    
                }) {
    
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.MainColor)
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, -20)

            // Child Account Section
            VStack(alignment: .leading, spacing: 10) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        VStack {
                            
                            
                            HStack {
                                VStack {
                                    Button(action: {
                                        // Navigate to child profile
                                    }) {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.bottom, 5)
                                    .padding(10)
                                    
                                    Text("Jessica")
                                            .font(.title3)
                                        .foregroundColor(.white)
                                    
                                    Text("Age 16")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 10)
                            }
                              
                                
                                HStack {
                                    VStack {
                                        Text("Balance")
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 50)
                                            .padding(.horizontal, 25)
                                        
                                        Text("$248.98")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    
                                    
                                    VStack {
                                        Text("Credit")
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 50)
                                            
                                
                                        Text("792")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                }
                                .font(.subheadline)
                            }
                        }
                        .padding()
                        .background(Color("BLACK2"))
                        .cornerRadius(15)
                    }
                }
            }
            .padding(20)
            .padding(.horizontal, -5)
            
            Spacer()

            // Tips & Tricks Section
            VStack(alignment: .leading) {
                Text("Tips & Tricks")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.bottom, 0)
                
                VStack(spacing: 0) {
                    // Card Settings
                    
                    HStack {
                        Image(systemName: "applelogo")
                            .foregroundColor(Color.white)
                        
                        Text("This is Tip 1")
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    VStack {
                        Divider()
                            .background(Color.black)
                    }
                    
                    
                        HStack {
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(Color.white)
                            
                            Text("Tip 2 is right here")
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                    
                    
                    VStack {
                        Divider()
                            .background(Color.black)
                    }
                    
                    
                        HStack {
                            Image(systemName: "arrow.2.squarepath")
                                .foregroundColor(Color.white)
                            
                            Text("Tip 3 here")
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                    
                    VStack {
                        Divider()
                            .background(Color.black)
                    }
                    
                    
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(Color.white)
                            
                            Text("Tip 4 here")
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding()
                    
                }
                .background(Color("BLACK2"))
                .cornerRadius(15)
                .padding()
            }

            Spacer()

            HStack {
                Button(action: {
                    // Home action
                }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.MainColor)
                }
                Spacer()
                Button(action: {
                    // Search action
                }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    // Settings action
                }) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .padding(.top, 10)
            .padding(.bottom, 30) // Bottom padding set to 30
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
                    .padding(.horizontal, -25) // Extend the horizontal borders
            )
            .offset(y: 50) // Move down by 65


        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

// Example Tips Data
let tips = [
    (title: "How to build credit", description: "Start by using a secured credit card."),
    (title: "Saving tips for teens", description: "Save 10% of your earnings each month."),
    (title: "Understanding your credit score", description: "Learn about factors affecting your credit.")
]

struct ParentDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ParentDashboardView()
    }
}
