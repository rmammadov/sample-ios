//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct DefaultTextFieldModifier: ViewModifier {
    let placeHolder: String?
    let text: Binding<String>
    let isFocused: FocusState<Bool>.Binding
    let isContentNotValid: () -> Bool
    let keyboardType: UIKeyboardType
    let autoCapitalizationType: UITextAutocapitalizationType?

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .textFieldStyle(DefaultTextFieldStyle())
                .frame(height: 40)
                .padding(.horizontal, 12)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(isContentNotValid() ? ElementStyles.textFielError : (isFocused.wrappedValue ? ElementStyles.textFielActive : ElementStyles.textFielInactive),
                            lineWidth: 1))
                .accentColor(R.color.versalGray100.color())
                .keyboardType(keyboardType)
                .autocapitalization(autoCapitalizationType ?? .none)
                .focused(isFocused)
        }
    }
}
