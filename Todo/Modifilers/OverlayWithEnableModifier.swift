//
//  OverlayWithEnableModifier.swift
//  Todo
//  
//  Created by NAKASUJI HIROKI on 2025/03/12
//  
//

import Foundation
import SwiftUI

struct OverlayWithEnableModifier<OverlayContent: View>: ViewModifier {
    @Binding var isEnabled: Bool
    let overlayContent: () -> OverlayContent

    func body(content: Content) -> some View {
        if isEnabled {
            content
                .overlay(overlayContent())
        } else {
            content
        }
    }
}

extension View {
    func overlay<OverlayContent: View>(
        _ isEnabled: Binding<Bool>,
        @ViewBuilder content: @escaping () -> OverlayContent
    ) -> some View {
        modifier(OverlayWithEnableModifier(isEnabled: isEnabled, overlayContent: content))
    }
}
