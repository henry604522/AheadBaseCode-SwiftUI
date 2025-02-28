//
//  SavingsGoal.swift
//  Ahead
//
//  Created by Henry MacLane on 10/22/24.
//

import SwiftUI

struct SavingsGoal: Identifiable {
    let id = UUID()
    var name: String
    var targetAmount: Double
    var savedAmount: Double
    var targetDate: Date
}
