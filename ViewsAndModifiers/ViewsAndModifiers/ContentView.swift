//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by SUNG HAO LIN on 2022/8/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world")
            .makeLargeBlueTitle(with: "Today is Day24")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
 Button {
     print(type(of: self.body))
 } label: {
     Text("Hello, world")
 }
 .background(.green)
 .frame(width: 200, height: 200)
 
 會印出 ->
 ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>
 
 */
