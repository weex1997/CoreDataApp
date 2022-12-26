//
//  CoreDataAppApp.swift
//  CoreDataApp
//
//  Created by Wedad Almehmadi on 26/12/2022.
//

import SwiftUI

@main
struct CoreDataAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
