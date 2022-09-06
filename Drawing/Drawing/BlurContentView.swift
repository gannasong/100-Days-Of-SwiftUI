//
//  BlurContentView.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/24.
//

import SwiftUI

struct BlurContentView: View {
    @State var amount: CGFloat = 0.0
    
    var body: some View {
        VStack {
            // Sample 1
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
            
            // Sample 2
            Image("Example")
                .resizable()
                .scaledToFit()
                .saturation(amount) // 飽和
                .blur(radius: (1 - amount) * 20) // 數字越大越模糊
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct BlurContentView_Previews: PreviewProvider {
    static var previews: some View {
        BlurContentView()
    }
}
