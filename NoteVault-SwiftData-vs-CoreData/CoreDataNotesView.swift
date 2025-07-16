//
//  CoreDataNotesView.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-16.
//

// ================================
// MARK: - CoreData Version
// ================================

import SwiftUI
import CoreData

//extension NoteEntity: Identifiable {}

struct CoreDataNotesView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        entity: NoteEntity.entity(), // this must match the loaded entity
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.timestamp, ascending: false)]
    ) private var notes: FetchedResults<NoteEntity>


    @State private var newNoteTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter note...", text: $newNoteTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Add Note") {
                    let newNote = NoteEntity(context: context)
                    newNote.title = newNoteTitle
                    newNote.timestamp = Date()

                    do {
                        try context.save()
                        newNoteTitle = ""
                    } catch {
                        print("Failed to save note: \(error)")
                    }
                }
                .padding(.bottom)

                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title ?? "Untitled")
                                .font(.headline)
                            Text(note.timestamp?.formatted() ?? "No date")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
            }
            .navigationTitle("CoreData Notes")
        }
    }

    private func deleteNotes(at offsets: IndexSet) {
        for index in offsets {
            let note = notes[index]
            context.delete(note)
        }
        do {
            try context.save()
        } catch {
            print("Failed to delete note: \(error)")
        }
    }
}
