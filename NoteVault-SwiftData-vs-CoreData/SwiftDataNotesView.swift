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
                HStack{
                    Spacer()
                    Text("SwiftData Notes 💡")
                        .font(.title)
                        .foregroundColor(.cyan)
                    Spacer()
                    
                }//:HStack
                .padding(.horizontal,20)
                TextField("Enter note...", text: $newNoteTitle)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Add Note") {
                    let newNote = Note(title: newNoteTitle)
                    context.insert(newNote)
                    newNoteTitle = ""
                }
                .modifier(OutlineBtnStyle(maxWidth: .infinity,minHeight: 56))
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.bottom)

                List {
                    ForEach(notes) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .foregroundColor(.black.opacity(0.7))
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
        }
    }
}

