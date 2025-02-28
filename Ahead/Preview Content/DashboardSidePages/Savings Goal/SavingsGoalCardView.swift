//
//  SavingsGoalCardView.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct SavingsGoalCardView: View {
    let goal: SavingsGoal
    let onDelete: () -> Void
    let onAddMoney: () -> Void
    let onRemoveMoney: () -> Void
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Image (if user selects one)
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .cornerRadius(10)
                    .clipped()
            } else {
                Button(action: {
                    showingImagePicker = true
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 150)
                            .cornerRadius(10)
                        Text("Add Image")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePickerSavings(image: $selectedImage)
                }
            }
            
            // HStack for goal name and delete button
            HStack {
                Text(goal.name)
                    .font(.headline)
                    .foregroundStyle(Color.white)
                Spacer()
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            Text("$\(goal.savedAmount, specifier: "%.2f") / $\(goal.targetAmount, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundStyle(Color.white)
            
            Text("By \(goal.targetDate, formatter: DateFormatter.shortDate)")
                .font(.caption)
                .foregroundStyle(Color.white)
            
            HStack {
                Button(action: onAddMoney) {
                    Text("Add Money")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                Button(action: onRemoveMoney) {
                    Text("Remove Money")
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color("BLACK2")) // White background for each card
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

