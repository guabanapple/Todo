//
//  ContentView.swift
//  Todo
//
//  Created by 中筋裕樹 on 2025/02/08.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var multiSelection: Set<UUID> = []
    @State private var todoItems: [TodoItem] = [
        TodoItem(title: "one"),
        TodoItem(title: "two"),
        TodoItem(title: "three"),
    ]
    
    var body: some View {
        VStack {
            TextField("New Todo", text: $inputText)
            Button("Add") {
                if removeSpace(inputText).isEmpty { return }
                todoItems.append(TodoItem(title: inputText))
                inputText = ""
            }
            List(selection: $multiSelection) {
                ForEach(todoItems) { todo in
                    todo.isDone
                    ? Text(todo.title).strikethrough().tag(todo.id)
                    : Text(todo.title).tag(todo.id)
                    
                }
                .onMove(perform: moveRow)
            }
            HStack {
                Button("Done") {
                    let selectedIndexes = multiSelection.compactMap { uuid in
                        todoItems.firstIndex(where: { $0.id == uuid})
                    }
                    let isAllSame = Set(selectedIndexes.map { todoItems[$0].isDone }).count == 1
                    selectedIndexes.forEach {
                        todoItems[$0].isDone = isAllSame ? !todoItems[$0].isDone : true
                    }
                }
                Button("Delete") {}
            }
        }
        .padding()
        .environment(\.editMode, .constant(.active))
    }
    
    private func moveRow(from source: IndexSet, to destination: Int) {
        todoItems.move(fromOffsets: source, toOffset: destination)
    }
    
    private func removeSpace(_ origin: String) -> String {
        return origin.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    ContentView()
}

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var isDone: Bool = false
}
