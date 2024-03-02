//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct PlainTextField: View {
    // MARK: Internal

    // MARK: - Internal Properties
    @Binding var text: String
    @FocusState var isFocused: Bool

    let autoCapitalizationType: UITextAutocapitalizationType?
    let errorText: String
    let isNotValid: Bool
    let keyboardType: UIKeyboardType
    let placeHolder: String?
    let title: String

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            TextStyles.textFieldTitle(Text(title))
                .padding(.bottom, 8)

            TextStyles.textField(TextField(placeHolder ?? title, text: $text))
                .focused($isFocused)
                .modifier(DefaultTextFieldModifier(placeHolder: placeHolder ?? title,
                                                   text: $text,
                                                   isFocused: $isFocused,
                                                   isContentNotValid: { isContentNotValid() },
                                                   keyboardType: keyboardType,
                                                   autoCapitalizationType: autoCapitalizationType ?? UITextAutocapitalizationType.none))

            if isContentNotValid() {
                TextStyles.errorLabel(Label(errorText, image: R.image.ic_error.name))
                    .padding(.top, 8)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }

    // MARK: Private

    // MARK: - Private Methods
    private func isContentNotValid() -> Bool {
        if isNotValid, !text.isEmpty {
            return true
        } else {
            return false
        }
    }
}
