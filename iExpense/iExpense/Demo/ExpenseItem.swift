//
//  ExpenseItem.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/16.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    var backgroundColor: Color {
        if amount < 10 {
            return .white
        } else if amount >= 10 && amount < 100 {
            return .orange.opacity(0.5)
        } else {
            return .red.opacity(0.5)
        }
    }
}
