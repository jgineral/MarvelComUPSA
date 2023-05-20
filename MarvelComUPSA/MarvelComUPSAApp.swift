//
//  MarvelComUPSAApp.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 20/5/23.
//

import SwiftUI

@main
struct MarvelComUPSAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
