//
//  GraphicalDatePicker.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/10
//
//

import SwiftUI

struct GraphicalDatePicker: View {
    @Binding var selectedDate: Date?
    @Binding var isDatePickerShown: Bool
    @State var savedDate = Date()
    
    var body: some View {
        ZStack {
            OverlayBackground(isShown: $isDatePickerShown)
            VStack {
                DatePicker(
                    "",
                    selection: $savedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                Divider()
                HStack {
                    Button("Cancel") {
                        isDatePickerShown = false
                    }
                    .padding()
                    Button("Save") {
                        selectedDate = savedDate
                        isDatePickerShown = false
                    }
                    .padding()
                    if let _ = selectedDate {
                        Button("Delete", role: .destructive) {
                            selectedDate = nil
                            isDatePickerShown = false
                        }
                        .padding()
                    }
                }
            }
            .frame(maxWidth: 400)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 4)
            // 領域内タップがオーバーレイ背景に伝播するのを防ぐため
            .onTapGesture {}
        }
    }
}
