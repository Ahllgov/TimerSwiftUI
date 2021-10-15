//
//  TimerSwiftUIApp.swift
//  Shared
//
//  Created by Магомед Ахильгов on 15.10.2021.
//

import SwiftUI

@main
struct TimerSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
