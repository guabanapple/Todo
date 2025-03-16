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
            if isInvalid() { return }
            let titleValue = TodoUtils.trim(todoTitleInput).isEmpty ? "New Todo" : todoTitleInput
            let noteValue = TodoUtils.trim(noteInput).isEmpty ? nil : noteInput
            
            let item = TodoItem(title: titleValue, notes: noteValue, remindDate: remindDate, limit: limitDate)
            context.insert(item)
        }
    }
    
    
    
    // 全てが空（入力も選択もされていない）場合のみ Invalid とみなす
    private func isInvalid() -> Bool {
        let isTitleEmp = TodoUtils.trim(todoTitleInput).isEmpty
        let isNoteEmp = TodoUtils.trim(noteInput).isEmpty
        let isSelectedDateEmp = remindDate == nil && limitDate == nil
        // TODO: tag
        return isTitleEmp && isNoteEmp && isSelectedDateEmp
    }
}
