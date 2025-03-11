//
//  ContentView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/02/08.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isNewItemViewShown: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TodoList()
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
