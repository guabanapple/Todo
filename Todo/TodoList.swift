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
                        HStack {
                            @Bindable var bt = todo
                            Toggle(isOn: $bt.isDone) {
                            }
                            .toggleStyle(.checkBox)
                            
                            // decoration of title
                            todo.isDone
                            ? Text(todo.title).strikethrough().tag(todo.id)
                            : Text(todo.title).tag(todo.id)
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
    
    private func moveRow(from source: IndexSet, to destination: Int) {
        //        todoItems.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteRow(offsets: IndexSet) {
        context.delete(todos[offsets.first!])
    }
}
