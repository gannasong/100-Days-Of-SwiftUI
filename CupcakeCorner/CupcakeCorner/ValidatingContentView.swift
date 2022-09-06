//
//  ValidatingContentView.swift
//  CupcakeCorner
//
//  Created by SUNG HAO LIN on 2022/8/27.
//

import SwiftUI

struct ValidatingContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ValidatingContentView_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingContentView()
    }
}
