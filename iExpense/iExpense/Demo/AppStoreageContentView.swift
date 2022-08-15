//
//  AppStoreageContentView.swift
//  iExpense
//
//  Created by SUNG HAO LIN on 2022/8/15.
//

import SwiftUI

struct AppStoreageContentView: View {
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct AppStoreageContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppStoreageContentView()
    }
}
