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
    @State var limitDatePcikerShown: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                OverlayBackground(isShown: $isPresented) {
                    // validation
                    if isInvalid() { return }
                    let titleValue = trim(todoTitleInput).isEmpty ? "New Todo" : todoTitleInput
                    let noteValue = trim(noteInput).isEmpty ? nil : noteInput
                    
                    let item = TodoItem(title: titleValue, notes: noteValue)
                    context.insert(item)
                }
                VStack {
                    TextField("New Todo", text: $todoTitleInput)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    TextField("Note", text: $noteInput, axis: .vertical)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    
                    HStack {
                        Spacer().frame(width: 20)
                        Image(systemName: "bell")
                        Button(formatDate(remindDate, includeTime: true) ?? "Today") {
                            remandDatePickerShown = true
                        }
                        Spacer()
                        Button(
                            action: {
                            },
                            label: {
                                Image(systemName: "tag")
                            })
                        // limitDateに値がある場合はremindDateの下に表示
                        if limitDate == nil {
                            Button(
                                action: {
                                    limitDatePcikerShown = true
                                },
                                label: {
                                    Image(systemName: "flag.circle")
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
                            Button(formatDate(limitDate, includeTime: false)!) {
                                limitDatePcikerShown = true
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
                    $limitDatePcikerShown,
                    content: {
                        GraphicalDatePicker(selectedDate: $limitDate, isDatePickerShown: $limitDatePcikerShown, displayedComponents: .date)
                    }
                )
                .overlay(
                    $remandDatePickerShown,
                    content: {
                        GraphicalDatePicker(
                            selectedDate: $remindDate, isDatePickerShown: $remandDatePickerShown)
                    })
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    
    private func formatDate(_ date: Date?, includeTime: Bool) -> String? {
        guard let date = date else { return nil }

        let calendar = Calendar.current
        let isThisYear = calendar.isDate(date, equalTo: Date(), toGranularity: .year)

        if includeTime {
            dateFormatter.dateFormat = isThisYear ? "M月d日(E) HH:mm" : "yyyy年M月d日(E) HH:mm"
        } else {
            dateFormatter.dateFormat = isThisYear ? "M月d日(E)" : "yyyy年M月d日(E)"
        }
        return dateFormatter.string(from: date)
    }
    
    private func trim(_ value: String) -> String {
        return value.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // 全てが空（入力も選択もされていない）場合のみ Invalid とみなす
    private func isInvalid() -> Bool {
        let isTitleEmp = trim(todoTitleInput).isEmpty
        let isNoteEmp = trim(noteInput).isEmpty
        let isSelectedDateEmp = remindDate == nil && limitDate == nil
        // TODO: tag
        return isTitleEmp && isNoteEmp && isSelectedDateEmp
    }
}

/*
 self.tags = tags
 */
