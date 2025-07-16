//
//  Persistence.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-16.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model") // Match your .xcdatamodeld filename
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
    }
}

