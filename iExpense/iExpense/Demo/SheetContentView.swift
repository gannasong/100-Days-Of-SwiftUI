//
//  SheetContentView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/15.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, \(name)")
            
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

struct SheetContentView: View {
    @State private var showingSheet: Bool = false
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Text("Show Sheet")
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Python!")
        }
    }
}

struct SheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        SheetContentView()
    }
}
