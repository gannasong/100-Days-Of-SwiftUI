//
//  DrawingGroupContentView.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/23.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
                    .inset(by: Double(value))
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup() // 加了就不卡!神奇
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupContentView: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct DrawingGroupContentView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupContentView()
    }
}
