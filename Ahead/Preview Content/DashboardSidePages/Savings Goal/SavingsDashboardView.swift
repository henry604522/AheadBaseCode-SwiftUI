//
//  Savings Goals.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct SavingsDashboardView: View {
    @State private var savingsGoals: [SavingsGoal] = [
        SavingsGoal(name: "Bahamas Trip", targetAmount: 500.0, savedAmount: 0.0, targetDate: Date())
    ]
    @State private var showingAddGoal = false
    @State private var showingAddRemoveMoney = false
    @State private var selectedGoal: SavingsGoal?
    @State private var isAddingMoney = true
    
    // Computed property to calculate the total savings
        var totalSaved: Double {
            savingsGoals.reduce(0) { $0 + $1.savedAmount }
        }
    
    var body: some View {
        NavigationView {
            VStack {
                
            VStack(alignment: .leading) {
                
                Text("Savings")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .bold()
                    .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 75)
                    .overlay(
                        HStack {
                            Image("piggy")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("General Savings")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                Text("$500")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.title)
                            }
                
                            Spacer()
                            
                                
                                .padding(.trailing, -110)
                        }
                            .padding()
                    )
                    .padding()
            }
                
                VStack {
                    Divider()
                }
                .background(Color.white)
                // HStack for title and add button
                HStack {
                    Text("Savings Goals")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .bold()
                    Spacer()
                    Button(action: {
                        showingAddGoal = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color("MainColor")) // Circle color
                                .frame(width: 35, height: 35) // Adjust the size as needed
                            Image(systemName: "plus")
                                .scaledToFit()
                                .frame(height: 35)
                                .foregroundColor(.white) // Plus icon color
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Scrollable list of savings goals (now vertical)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(savingsGoals) { goal in
                            SavingsGoalCardView(goal: goal, onDelete: {
                                deleteGoal(goal)
                            }, onAddMoney: {
                                selectedGoal = goal
                                isAddingMoney = true
                                showingAddRemoveMoney = true
                            }, onRemoveMoney: {
                                selectedGoal = goal
                                isAddingMoney = false
                                showingAddRemoveMoney = true
                            })
                            .frame(maxWidth: .infinity)
                            .background(Color("BLACK2"))
                            .cornerRadius(10)
                            .padding(.horizontal, 20) // Padding for full-width effect
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .background(Color(.black).edgesIgnoringSafeArea(.all)) // Background color
            .navigationTitle("") // No title on the navigation bar
            .navigationBarHidden(true) // Hide the default navigation bar
            .sheet(isPresented: $showingAddGoal) {
                AddSavingsGoalView { newGoal in
                    savingsGoals.append(newGoal)
                }
            }
            .sheet(isPresented: $showingAddRemoveMoney) {
                if let goal = selectedGoal {
                    AddRemoveMoneyView(goal: goal, isAddingMoney: isAddingMoney) { amount in
                        if let index = savingsGoals.firstIndex(where: { $0.id == goal.id }) {
                            if isAddingMoney {
                                savingsGoals[index].savedAmount += amount
                            } else {
                                savingsGoals[index].savedAmount = max(0, savingsGoals[index].savedAmount - amount)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteGoal(_ goal: SavingsGoal) {
        savingsGoals.removeAll { $0.id == goal.id }
    }
}


#Preview {
    SavingsDashboardView()
}
