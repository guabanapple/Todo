//
//  OverlayBackground.swift
//  Todo
//
//  Created by NAKASUJI HIROKI on 2025/03/11
//
//

import SwiftUI

struct OverlayBackground: View {
    @Binding var isShown: Bool
    var autoCloseOnTapOutside: Bool = true
    var tapOutsideAction: (() -> Void)?
    
    var body: some View {
        Color.black.opacity(0.2)
            .ignoresSafeArea(edges: .all)
            .onTapGesture {
                tapOutsideAction?()
                if autoCloseOnTapOutside {
                    isShown = false
                }
            }
    }
}
