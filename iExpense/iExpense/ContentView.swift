//
//  ContentView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.personalItems.filter { $0.type == "Personal" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                        .listRowBackground(item.backgroundColor)
                    }
                    .onDelete { indexSet in
                        expenses.personalItems.remove(atOffsets: indexSet)
                    }
                }
                .headerProminence(.increased)
                
                Section(header: Text("Business")) {
                    ForEach(expenses.businessItems.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                        .listRowBackground(item.backgroundColor)
                    }
                    .onDelete { indexSet in
                        expenses.businessItems.remove(atOffsets: indexSet)
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
//    func removeItems(at offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
