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
    private static let today = Date.now
    @Query var todos: [TodoItem]
    @Binding var isEditing: Bool
    @Binding var selectedTodo: TodoItem?
    var mode: DisplayMode
    
    var body: some View {
        VStack {
            let items = getTodo(for: mode)
            if !items.isEmpty {
                List {
                    ForEach(items) { todo in
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
                Spacer()
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
    
    private func getTodo(for mode: DisplayMode) -> [TodoItem] {
        switch mode {
        case .future:
            return todos.filter({ $0.remindDate.isFutureDate() })
        case .today:
            return todos.filter({ $0.remindDate.isSameDate(as: Date()) })
        case .past:
            return todos.filter({ $0.remindDate.isPastDate() })
        }
    }
}

enum DisplayMode: Hashable {
    case future
    case today
    case past
}
