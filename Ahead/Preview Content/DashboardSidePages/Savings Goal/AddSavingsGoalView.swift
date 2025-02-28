//
//  AddSavingsGoalView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct AddSavingsGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var targetAmount: Double? = nil
    @State private var targetDate: Date = Date()
    
    var onSave: (SavingsGoal) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Goal Details").foregroundColor(.white)) {
                        CustomTextField(placeholder: Text("Goal Name"), text: $name)
                        TextField("Target Amount", value: $targetAmount, formatter: NumberFormatter())
                                                    .keyboardType(.decimalPad)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(Color("BLACK2"))
                                                    .cornerRadius(8)
                        DatePicker("Target Date", selection: $targetDate, displayedComponents: .date)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("BLACK2"))
                            .cornerRadius(8)
                    }
                    .listRowBackground(Color.black)
                }
                .background(Color.black)
                
                Button(action: addGoal) {
                    Text("Add Goal")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("MainColor"))
                        .cornerRadius(25)
                }
                .disabled(name.isEmpty || targetAmount == nil)
                .padding()
            }
            .background(Color.black)
            .navigationTitle("Add New Goal")
            .foregroundColor(.white)
        }
    }
    
    private func addGoal() {
        guard let amount = targetAmount else { return }
        let newGoal = SavingsGoal(name: name, targetAmount: amount, savedAmount: 0.0, targetDate: targetDate)
        onSave(newGoal)
        presentationMode.wrappedValue.dismiss()
    }
}

