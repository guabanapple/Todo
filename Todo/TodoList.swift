//
//  TodoList.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/24.
//

import SwiftUI

struct TodoList: View {
    @Environment(\.modelContext) var context
    @Binding var isEditing: Bool
    @Binding var selectedTodo: TodoItem?
    @State var todos: [TodoItem]      // 生の変数なら？
    var mode: DisplayMode
    
    var body: some View {
        VStack {
            if !todos.isEmpty {
                List {
                    ForEach(todos) { todo in
                        HStack {
                            @Bindable var bt = todo
                            Toggle(isOn: $bt.isDone) {}
                                .toggleStyle(.checkBox)
                                .padding(5)
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

enum DisplayMode: Hashable {
    case future
    case today
    case past
}
