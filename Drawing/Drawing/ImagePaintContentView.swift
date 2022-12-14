//
//  ImagePaintContentView.swift
//  Drawing
//
//  Created by SUNG HAO LIN on 2022/8/23.
//

import SwiftUI

struct ImagePaintContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .frame(width: 200, height: 200)
                .background(Image("Example").resizable())
            
            Text("Hello World")
                .frame(width: 200, height: 200)
                .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
            
            Text("Hello World")
                .frame(width: 200, height: 200)
                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}

struct ImagePaintContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintContentView()
    }
}
