//
//  ColorCyclingRectangleView.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/25.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startPoint: UnitPoint = .top
    var endPoint: UnitPoint = .bottom
    
    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
//                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: startPoint,
                            endPoint: endPoint
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

enum UnitPoints: String, CaseIterable {
    case top
    case bottom
    case leading
    case trailing
}

struct ColorCyclingRectangleView: View {
    @State private var colorCycle = 0.0
    @State private var startPoint: UnitPoints = .top
    @State private var endPoint: UnitPoints = .bottom
    
    func mapUnitPoint(_ type: UnitPoints) -> UnitPoint {
        switch type {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            ColorCyclingRectangle(amount: colorCycle,
                                  startPoint: mapUnitPoint(startPoint),
                                  endPoint: mapUnitPoint(endPoint))
                .frame(width: 300, height: 300)

            Group {
                Text("ColorCycle: \(colorCycle)")
                    .bold()
                Slider(value: $colorCycle)
                    .padding()
                
                Text("StartPoint")
                    .bold()
                Picker("startPoint", selection: $startPoint) {
                    ForEach(UnitPoints.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                            .tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                
                Text("EndPoint")
                    .bold()
                Picker("endPoint", selection: $endPoint) {
                    ForEach(UnitPoints.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                            .tag(unit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
            }
        }
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}
