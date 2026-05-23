//
//  ContactManagerApp.swift
//  ContactManager
//
//  Created by Santana, Marcelo de Carvalho on 23/05/26.
//

import SwiftUI
import CoreData

@main
struct ContactManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
