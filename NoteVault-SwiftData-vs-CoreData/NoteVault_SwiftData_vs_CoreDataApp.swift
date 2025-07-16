//
//  NoteVault_SwiftData_vs_CoreDataApp.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-16.
//

import SwiftUI

enum StorageMode {
    case coreData, swiftData
}

//let currentStorage: StorageMode = .swiftData
let currentStorage: StorageMode = .coreData

@main
struct NoteVault_SwiftData_vs_CoreDataApp: App {
    
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch currentStorage {
                case .swiftData:
                    SwiftDataNotesView()
                case .coreData:
                    CoreDataNotesView()
                        .environment(\.managedObjectContext, persistence.container.viewContext)
                }
            }
            .applyStorageConfig(currentStorage)
        }
    }
}

extension View {
    func applyStorageConfig(_ mode: StorageMode) -> some View {
        switch mode {
        case .swiftData:
            return AnyView(self.modelContainer(for: Note.self))
        case .coreData:
            return AnyView(self.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext))
        }
    }
}
