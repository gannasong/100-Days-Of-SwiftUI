//
//  OnDeleteContentView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/15.
//

import SwiftUI

struct OnDeleteContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct OnDeleteContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnDeleteContentView()
    }
}
