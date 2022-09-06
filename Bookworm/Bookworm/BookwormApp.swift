//
//  BookwormApp.swift
//  Bookworm
//
//  Created by SUNG HAO LIN on 2022/8/31.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
