//
//  SwiftDataNotesView.swift
//  NoteVault-SwiftData-vs-CoreData
//
//  Created by Sachindra Fernando on 2025-07-16.
//

// ================================
// MARK: - SwiftData Version
// ================================

import SwiftUI
import SwiftData

@Model
class Note {
    var title: String
    var timestamp: Date

    init(title: String, timestamp: Date = .now) {
        self.title = title
        self.timestamp = timestamp
    }
}

struct SwiftDataNotesView: View {
    @Query var notes: [Note]
    @Environment(\.modelContext) private var context
    @State private var newNoteTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter note...", text: $newNoteTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Add Note") {
                    let newNote = Note(title: newNoteTitle)
                    context.insert(newNote)
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
                    }
                }
            }
            .navigationTitle("SwiftData Notes")
        }
    }
}

