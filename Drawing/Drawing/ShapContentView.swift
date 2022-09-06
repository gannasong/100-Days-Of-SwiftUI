//
//  ShapContentView.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/24.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double
    
    // 需要 override 這個變數
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // rect 就是外部設定的 frame
        
        var path = Path()
        // rect: (0.0, 0.0, 200.0, 100.0) (x, y, width, height)
        print("🟠 rect: ", rect)
        // insetAmount:  50.0
        print("🟠 insetAmount: ", insetAmount)
        // rect.minY:  0.0
        print("🟠 rect.minY: ", rect.minY) // 左上
        // rect.maxY:  100.0
        print("🟠 rect.maxY: ", rect.maxY) // 右上
        // rect.minX:  0.0
        print("🟠 rect.minX: ", rect.minX) // 左下
        // rect.maxX:  200.0
        print("🟠 rect.maxX: ", rect.maxX) // 右下
        
        // 左下起點 -> 往左上走 -> 往右上走 -> 往右下走 -> 往左下走
        path.move(to: CGPoint(x: 0, y: rect.maxY)) // 左下起點
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY)) // 左上
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY)) // 右上
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // 右下
        path.addLine(to: CGPoint(x: 0, y: rect.maxY)) // 左下
        
        return path
    }
}

struct ShapContentView: View {
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .background(Color.red.opacity(0.3))
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
    }
}

struct ShapContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShapContentView()
    }
}
