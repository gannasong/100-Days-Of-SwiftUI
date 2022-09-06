//
//  AsyncImageContentView.swift
//  CupcakeCorner
//
//  Created by SUNG HAO LIN on 2022/8/27.
//

import SwiftUI

struct AsyncImageContentView: View {
    var body: some View {
        // Demo1
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)
        
        // Demo2
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct AsyncImageContentView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageContentView()
    }
}
