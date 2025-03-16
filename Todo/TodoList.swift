//
//  TodoList.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/24.
//

import SwiftUI
import SwiftData

struct TodoList: View {
    @Environment(\.modelContext) var context
    @Query private var todos: [TodoItem]
    @State private var newTodoTitle: String = ""
    
    var body: some View {
        VStack {
            if !todos.isEmpty {
                List() {
                    ForEach(todos) { todo in
                        // TODO: 今日じゃないものはここに表示しない
                        HStack {
                            @Bindable var bt = todo
                            Toggle(isOn: $bt.isDone) {
                                Text(todo.title)
                            }
                            .toggleStyle(.checkBox)
                            
                            if todo.notes != nil {
                                noteIcon
                            }
                            // TODO: limitDate
                            // TODO: tags
                        }
                    }
                    .onMove(perform: moveRow)
                    .onDelete(perform: deleteRow)
                }
                .scrollContentBackground(.hidden)
            } else {
                Text("No todo items.")
                Spacer()
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
