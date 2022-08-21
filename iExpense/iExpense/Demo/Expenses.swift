//
//  Expenses.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/16.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    @Published var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "PersonalItems")
            }
        }
    }
    
    @Published var businessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(businessItems) {
                UserDefaults.standard.set(encoded, forKey: "BusinessItems")
            }
        }
    }
    
    init() {
        if let savePersonalItems = UserDefaults.standard.data(forKey: "PersonalItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savePersonalItems) {
                personalItems = decodedItems
            }
        } else {
            personalItems = []
        }
        
        if let savedBusinessItems = UserDefaults.standard.data(forKey: "BusinessItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedBusinessItems) {
                businessItems = decodedItems
            }
        } else {
            businessItems = []
        }
    }
}
