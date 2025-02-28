//
//  AddRemoveMoneyView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct AddRemoveMoneyView: View {
    @Environment(\.presentationMode) var presentationMode
    let goal: SavingsGoal
    let isAddingMoney: Bool
    @State private var amount: String = ""
    
    var onSave: (Double) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Text(isAddingMoney ? "Add Cash" : "Remove Money")
                    .font(.largeTitle)
                    .padding()
                
                Text(amount)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                
                NumberPadView(amount: $amount)
                
                Button(action: saveMoney) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(amount.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                }
                .disabled(amount.isEmpty)
                .padding()
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
    }
    
    private func saveMoney() {
        guard let money = Double(amount) else { return }
        onSave(money)
        presentationMode.wrappedValue.dismiss()
    }
}

struct NumberPadView: View {
    @Binding var amount: String
    
    private let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "⌫"]
    ]
    
    var body: some View {
        VStack {
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(width: 80, height: 80)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .padding(4)
                        }
                        .disabled(button.isEmpty)
                    }
                }
            }
        }
    }
    
    private func buttonTapped(_ button: String) {
        switch button {
        case "⌫":
            if !amount.isEmpty {
                amount.removeLast()
            }
        default:
            amount.append(button)
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

