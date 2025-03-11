//
//  NewItemView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/02
//
//

import SwiftUI
import SwiftData

struct NewItemView: View {
    @Environment(\.modelContext) var context
    @Binding var isPresented: Bool
    @State var todoTitleInput: String = ""
    @State var selectedDate: Date?
    @State var remandDatePickerShown: Bool = false
    @State var limitDatePcikerShown: Bool = false
    @State var noteInput: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                OverlayBackground(isShown: $isPresented) {
                    let todoTitle = todoTitleInput.trimmingCharacters(in: .whitespacesAndNewlines)
                    if todoTitle.isEmpty { return }
                    let item = TodoItem(title: todoTitleInput)
                    context.insert(item)
                }
                VStack {
                    TextField("New Todo", text: $todoTitleInput)
                        .frame(maxWidth: .infinity)
                        .padding()
                    TextField("Note", text: $noteInput, axis: .vertical)
                        .frame(maxWidth: .infinity)
                        .padding()
                    HStack {
                        Button(action: {
                            remandDatePickerShown = true
                        }, label: {
                            Image(systemName: "calendar.circle")
                        })
                        Button(action: {
                            limitDatePcikerShown = true
                        }, label: {
                            Image(systemName: "flag.circle")
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 2)
                // 領域内タップがオーバーレイ背景に伝播するのを防ぐため
                .onTapGesture {}
                //                if limitDatePcikerShown {
                //                    GraphicalDatePicker(selectedDate: $selectedDate, isDatePickerShown: $limitDatePcikerShown)
                //                } else if remandDatePickerShown {
                //                    GraphicalDatePicker(selectedDate: $selectedDate, isDatePickerShown: $remandDatePickerShown)
                //                }
                
            }
        }
    }
}

/*
 self.notes = notes
 self.remindDate = remindDate
 self.limit = limit
 self.tags = tags
 */
