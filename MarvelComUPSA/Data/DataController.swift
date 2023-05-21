//
//  DataController.swift
//  MarvelComUPSA
//
//  Created by Javier Giner Alvarez on 21/5/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    static let shared = DataController()

    var managedContext: NSManagedObjectContext {
        container.viewContext
    }

    let container = NSPersistentContainer(name: "MarvelComUPSA")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
