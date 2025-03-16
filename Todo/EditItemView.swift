//
//  EditItemView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/16
//
//

import SwiftUI

struct EditItemView: View {
  @Environment(\.modelContext) var context
  @Binding var isPresented: Bool
  @State var todoTitleInput: String = ""
  @State var noteInput: String = ""
  @State var remindDate: Date?
  @State var limitDate: Date?
  @State var remandDatePickerShown: Bool = false
  @State var limitDatePcikerShown: Bool = false
  @State var todo: TodoItem

  init(isPresented: Binding<Bool>, todo: TodoItem) {
    _isPresented = isPresented
    _todo = State(initialValue: todo)
    _todoTitleInput = State(initialValue: todo.title)
    _noteInput = State(initialValue: todo.notes ?? "")
    _remindDate = State(initialValue: todo.remindDate)
    _limitDate = State(initialValue: todo.limit)
  }

  var body: some View {
    EditableItemView(
      isPresented: $isPresented,
      todoTitleInput: $todoTitleInput,
      noteInput: $noteInput,
      remindDate: $remindDate,
      limitDate: $limitDate,
      remandDatePickerShown: $remandDatePickerShown,
      limitDatePickerShown: $limitDatePcikerShown
    ) {
      // validation
      if isInvalid() { return }
      todo.title = TodoUtils.trim(todoTitleInput).isEmpty ? "New Todo" : todoTitleInput
      todo.notes = TodoUtils.trim(noteInput).isEmpty ? nil : noteInput
      todo.remindDate = remindDate
      todo.limit = limitDate
    }
    .addDeleteButton {
        print("deletebutton")
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
