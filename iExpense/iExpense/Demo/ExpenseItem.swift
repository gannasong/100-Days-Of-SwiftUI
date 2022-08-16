//
//  ExpenseItem.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/16.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
