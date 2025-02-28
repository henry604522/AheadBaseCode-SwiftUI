//
//  DateOfBirthView.swift
//  Ahead
//
//  Created by Henry MacLane on 12/7/24.
//

import SwiftUI
import Firebase

struct DateOfBirthView: View {
    @State private var dateOfBirth = Calendar.current.date(byAdding: .year, value: -12, to: Date())!
    private var minDate: Date {
        return Calendar.current.date(byAdding: .year, value: -100, to: Date())!
    }
    private var maxDate: Date {
        return Calendar.current.date(byAdding: .year, value: -12, to: Date())!
    }

    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: SignInView()) { // Replace `ContentView` with the previous view
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.white)
                        .padding()
                }
                ProgressView(value: 1, total: 6)
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
                Text("What's your ")
                    .foregroundColor(.white) +
                Text("date of birth")
                    .foregroundColor(Color("MainColor"))
            }
            .font(.title)
            .padding()

            DatePicker("", selection: $dateOfBirth, in: minDate...maxDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .colorInvert()
                .padding()

            Spacer()

            NavigationLink(destination: EmailView()) {
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
}

struct DateOfBirthView_Previews: PreviewProvider {
    static var previews: some View {
        DateOfBirthView()
    }
}



