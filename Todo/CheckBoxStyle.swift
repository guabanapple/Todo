//
//  CheckBoxStyle.swift
//  Todo
//
//  Created by 中筋裕樹 on 2025/02/23.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
            Button{
                configuration.isOn.toggle()
            } label: {
                HStack{
                    Image(systemName: configuration.isOn
                          ? "checkmark.square"
                          : "square")
                    configuration.label
                }
            }
            .foregroundStyle(configuration.isOn ? Color.accentColor : .primary)
        }
}

extension ToggleStyle where Self == CheckBoxStyle {
    static var checkBox: CheckBoxStyle {
        .init()
    }
}
