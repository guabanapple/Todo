//
//  ContentView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/08.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var todoItem: TodoItem? = nil
    @State var isNewItemViewShown: Bool = false
    @State var isEditItemViewShown: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TodoList(isEditing: $isEditItemViewShown, selectedTodo: $todoItem)
                    Button {
                        isNewItemViewShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.blue)
                            .clipShape(.buttonBorder)
                    }
                }
                .navigationTitle("Todo")
                if isNewItemViewShown {
                    NewItemView(isPresented: $isNewItemViewShown)
                }
                if let item = todoItem, isEditItemViewShown {
                    EditItemView(isPresented: $isEditItemViewShown, todo: item)
                }
            }
        }
    }
    
    private func removeSpaceAndNewLines(_ origin: String) -> String {
        return origin.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    ContentView()
}
