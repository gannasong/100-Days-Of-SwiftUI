//
//  LargeBlueTitle.swift
//  ViewsAndModifiers
//
//  Created by SUNG HAO LIN on 2022/8/3.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 10) {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            content
        }
    }
}

extension View {
    func makeLargeBlueTitle(with text: String) -> some View {
        modifier(LargeBlueTitle(text: text))
    }
}
