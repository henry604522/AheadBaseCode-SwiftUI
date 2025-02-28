//
//  Message.swift
//  Ahead
//
//  Created by Henry MacLane on 10/28/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

func timeAgoSinceDate(_ date: Date) -> String {
    let minutes = Int(Date().timeIntervalSince(date) / 60)
    if minutes == 0 {
        return "just now"
    } else {
        return "\(minutes) min ago"
    }
}


