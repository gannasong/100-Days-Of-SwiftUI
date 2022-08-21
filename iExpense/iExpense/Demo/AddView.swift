//
//  AddView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/16.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var isDisabled: Bool {
        return !(!name.isEmpty && amount > 0.0)
    }
    
    let types = ["Personal", "Business"]
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        if type == "Personal" {
                            expenses.personalItems.append(item)
                        }
                        
                        if type == "Business" {
                            expenses.businessItems.append(item)
                        }
                        
                        dismiss()
                    }
                    .disabled(isDisabled)
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
