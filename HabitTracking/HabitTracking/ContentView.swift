//
//  ContentView.swift
//  HabitTracking
//
//  Created by SUNG HAO LIN on 2022/8/26.
//

import SwiftUI

struct Habit: Identifiable, Equatable {
    let id = UUID()
    let emoji: String
    let activity: String
    
}

//struct HabitExecute: Codable, Equatable {
//    let date: String
//    let
//}

class HabitModel: ObservableObject {
    @Published var habits: [Habit] = []
}

struct ContentView: View {
    @StateObject var habitState: HabitModel = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                if habitState.habits.isEmpty {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 50, height: 50)
                } else {
                    VStack {
                        Text("Hello, world!")
                            .padding()
                    }
                    .navigationTitle("Habit Tracking")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
