//
//  CoreDataNotesView.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-16.
//

// ================================
// MARK: - CoreData Version
// ================================

import CoreData
import SwiftUI

@objc(NoteEntity)
public class NoteEntity: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var timestamp: Date
}

extension NoteEntity: Identifiable {}

struct CoreDataNotesView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.timestamp, ascending: false)],
        animation: .default
    ) private var notes: FetchedResults<NoteEntity>

    @State private var newNoteTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter note...", text: $newNoteTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Add Note") {
                    let note = NoteEntity(context: context)
                    note.title = newNoteTitle
                    note.timestamp = Date()

                    try? context.save()
                    newNoteTitle = ""
                }
                .padding(.bottom)

                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.timestamp.formatted())
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete { indices in
                        for index in indices {
                            context.delete(notes[index])
                        }
                        try? context.save()
                    }
                }
            }
            .navigationTitle("CoreData Notes")
        }
    }
}
