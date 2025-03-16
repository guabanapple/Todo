//
//  ContentView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/08.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selectedTodo: TodoItem?
    @State var isNewDialogShown: Bool = false
    @State var isEditDialogShown: Bool = false
    @State var selectedTab: Int = 1
    private var modes: [DisplayMode] = [.past, .today, .future]
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    ForEach(Array(modes.enumerated()), id: \.element) { index, element in
                        Text("\(element)")
                            .font(.headline)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .onTapGesture {
                                withAnimation { selectedTab = index }
                            }
                    }
                }
                .padding(.horizontal, 10)
                
                Divider()
                TabView(selection: $selectedTab) {
                    ForEach(Array(modes.enumerated()), id: \.element) { index, element in
                        VStack {
                            TodoList(isEditing: $isEditDialogShown, selectedTodo: $selectedTodo, mode: element)
                        }
                        .tag(index)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                // View for display NewItemView
                Button {
                    isNewDialogShown.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                }
            }
            if isNewDialogShown {
                NewItemView(isPresented: $isNewDialogShown)
            }
            if let item = selectedTodo, isEditDialogShown {
                EditItemView(isPresented: $isEditDialogShown, todo: item)
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
