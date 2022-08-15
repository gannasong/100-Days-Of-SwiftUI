//
//  CodableContentView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/15.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct CodableContentView: View {
    @State private var user = User(firstName: "SungHao", lastName: "Lin")
    
    var body: some View {
        Button {
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(user)
                UserDefaults.standard.set(data, forKey: "UserData")
            } catch {
                fatalError("Save user data error!")
            }
        } label: {
            Text("Save User")
        }

    }
}

struct CodableContentView_Previews: PreviewProvider {
    static var previews: some View {
        CodableContentView()
    }
}
