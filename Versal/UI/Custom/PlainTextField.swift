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
            Text(title)
                .padding(.bottom, 8)
                .font(.system(size: 14))
                .font(Font.headline.weight(.medium))

            TextField(placeHolder ?? title,
                      text: $text,
                      onEditingChanged: { _ in },
                      onCommit: {})
                .focused($isFocused)
                .frame(height: 40)
                .padding(.horizontal, 12)
                .foregroundColor(.versalTextBlack)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(isContentNotValid() ? Color.red : (isFocused ? .versalPrimary500 : .versalGray100), lineWidth: 1))
                .font(.system(size: 12))
                .accentColor(.versalGray100)
                .keyboardType(keyboardType)
                .autocapitalization(autoCapitalizationType ?? .none)

            if isContentNotValid() {
                Label(errorText, image: R.image.ic_error.name)
                    .padding(.top, 8)
                    .font(.system(size: 12))
                    .foregroundColor(.versalError500)
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
