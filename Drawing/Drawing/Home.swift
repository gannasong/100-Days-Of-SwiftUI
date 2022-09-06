//
//  Home.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/25.
//

import SwiftUI

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY / 2))
        
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))
        path.move(to: CGPoint(x: rect.width / 2, y: 0))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 2))
        path.closeSubpath()
        return path
    }
}

struct Home: View {
    @State var lineWidth: CGFloat = 10
    @State var scaleAmount: CGFloat = 0.5
    @State var hue = 0.6
    
    // saturation 飽和度
    // brightness 亮度
    var body: some View {
        VStack(spacing: 8) {
            ArrowShape()
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .scaleEffect(scaleAmount)
                .frame(width: 200, height: 400)
                
            
            VStack {
                Text("LineWidth: \(lineWidth)")
                    .bold()
                Slider(value: $lineWidth, in: 1...20, step: 0.5)
                   
                Text("Scale")
                    .bold()
                Slider(value: $scaleAmount, in: 0.1...1, step: 0.1)
                
                Text("Color")
                    .bold()
                Slider(value: $hue)
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
