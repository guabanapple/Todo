//
//  TodoList.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/24.
//

import SwiftData
import SwiftUI

struct TodoList: View {
    @Environment(\.modelContext) var context
    @Query private var todos: [TodoItem]
    @Binding var isEditing: Bool
    @Binding var selectedTodo: TodoItem?
    
    var body: some View {
        ZStack {
            VStack {
                if !todos.isEmpty {
                    List {
                        ForEach(todos) { todo in
                            // TODO: 今日じゃないものはここに表示しない
                            HStack {
                                @Bindable var bt = todo
                                Toggle(isOn: $bt.isDone) {}
                                    .toggleStyle(.checkBox)
                                    .zIndex(1)
                                HStack {
                                    Text(todo.title)
                                    if todo.notes != nil {
                                        noteIcon
                                    }
                                    // TODO: limitDate
                                    // TODO: tags
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedTodo = todo
                                    isEditing = true
                                }
                            }
                        }
                        .onMove(perform: moveRow)
                        //          .onDelete(perform: deleteRow)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    Text("No todo items.")
                    Spacer()
                }
            }
        }
    }
    
    private var noteIcon: some View {
        Image(systemName: "list.clipboard")
            .resizable()
            .scaledToFit()
            .frame(height: 16)
            .foregroundColor(.secondary)
    }
    
    private func moveRow(from source: IndexSet, to destination: Int) {
        //        todoItems.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteRow(offsets: IndexSet) {
        context.delete(todos[offsets.first!])
    }
}
