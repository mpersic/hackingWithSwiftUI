//
//  Bo0kwormApp.swift
//  Bo0kworm
//
//  Created by COBE on 30/04/2021.
//

import SwiftUI

@main
struct Bo0kwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
