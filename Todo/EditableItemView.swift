//
//  EditableItemView.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/16
//
//

import SwiftUI
import SwiftData

struct EditableItemView: View {
    // 削除ボタンModifier用
    @State private var showDeleteButton: Bool = false
    var onDelete: (() -> Void)?
    
    @Binding var isPresented: Bool
    @Binding var todoTitleInput: String
    @Binding var noteInput: String
    @Binding var remindDate: Date?
    @Binding var limitDate: Date?
    @Binding var remandDatePickerShown: Bool
    @Binding var limitDatePickerShown: Bool
    var tapOutsideAction: (() -> Void)
    
    var body: some View {
        NavigationStack {
            ZStack {
                OverlayBackground(isShown: $isPresented) {
                    tapOutsideAction()
                }
                VStack {
                    let titleValue = TodoUtils.trim(todoTitleInput).isEmpty ? "New Todo" : todoTitleInput
                    let noteValue = TodoUtils.trim(noteInput).isEmpty ? "Note" : noteInput
                    
                    TextField(titleValue, text: $todoTitleInput)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    TextField(noteValue, text: $noteInput, axis: .vertical)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    
                    HStack {
                        Spacer().frame(width: 20)
                        Image(systemName: "bell")
                        Button(TodoUtils.formatDate(remindDate, includeTime: true) ?? "Today") {
                            remandDatePickerShown = true
                        }
                        Spacer()
                        Button(action: {
                            // TODO: 実装
                        }, label: {
                            Image(systemName: "tag")
                        })
                        // limitDateに値がある場合はremindDateの下に表示
                        if limitDate == nil {
                            Button(action: {
                                limitDatePickerShown = true
                                print("showDeleteBVutton?: \(showDeleteButton)")
                            }, label: {
                                Image(systemName: "flag.circle")
                            })
                        }
                        if showDeleteButton {
                            Button(action: {
                                print("deletebutton")
                            }, label: {
                                Image(systemName: "trash")
                            })
                        }
                        Spacer().frame(width: 20, height: 20)
                    }
                    .padding(.top, 10)
                    // limitDateに値がある場合はremindDateの下に表示
                    if let limitDate {
                        HStack {
                            Spacer().frame(width: 20)
                            Image(systemName: "flag")
                            Button(TodoUtils.formatDate(limitDate, includeTime: false)!) {
                                limitDatePickerShown = true
                            }
                            Spacer()
                        }
                        .padding(.top, 3)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.bottom, 10)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
                // 領域内タップがオーバーレイ背景に伝播するのを防ぐため
                .onTapGesture {}
                .overlay(
                    $limitDatePickerShown,
                    content: {
                        GraphicalDatePicker(
                            selectedDate: $limitDate, isDatePickerShown: $limitDatePickerShown,
                            displayedComponents: .date
                        )
                    }
                )
                .overlay(
                    $remandDatePickerShown,
                    content: {
                        GraphicalDatePicker(
                            selectedDate: $remindDate, isDatePickerShown: $remandDatePickerShown)
                    }
                )
            }
        }
    }
    
    private func isInvalid() -> Bool {
        return true
    }
}

// EditableItemView専用の拡張
extension EditableItemView {
    func addDeleteButton(action: @escaping () -> Void) -> some View {
        var view = self
        view.showDeleteButton = true
        view.onDelete = action
        return view
    }
}
