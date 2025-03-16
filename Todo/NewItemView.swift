//
//  NewItemView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/02
//
//

import SwiftData
import SwiftUI

struct NewItemView: View {
    @Environment(\.modelContext) var context
    @Binding var isPresented: Bool
    @State var todoTitleInput: String = ""
    @State var noteInput: String = ""
    @State var remindDate: Date?
    @State var limitDate: Date?
    @State var remandDatePickerShown: Bool = false
    @State var limitDatePickerShown: Bool = false
    
    var body: some View {
        EditableItemView(
            isPresented: $isPresented,
            todoTitleInput: $todoTitleInput,
            noteInput: $noteInput,
            remindDate: $remindDate,
            limitDate: $limitDate,
            remandDatePickerShown: $remandDatePickerShown,
            limitDatePickerShown: $limitDatePickerShown
        ) {
            // validation
            let titleValue = TodoUtils.trim(todoTitleInput).isEmpty ? "New Todo" : todoTitleInput
            let noteValue = TodoUtils.trim(noteInput).isEmpty ? nil : noteInput
            let item = TodoItem(title: titleValue, notes: noteValue, remindDate: remindDate ?? Date(), limit: limitDate)
            context.insert(item)
        }
    }
}
