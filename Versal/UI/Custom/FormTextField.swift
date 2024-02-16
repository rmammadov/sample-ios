//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct FormTextField: View {
    // MARK: Internal
    let errorText: String
    let isNotValid: Bool
    let placeHolder: String
    let title: String

    @FocusState var isFocused: Bool
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .padding(.bottom, 8)
                .font(.system(size: 14))
                .font(Font.headline.weight(.medium))

            TextField(placeHolder,
                      text: $text,
                      onEditingChanged: { _ in
                      },
                      onCommit: {})
                .focused($isFocused)
                .frame(height: 40)
                .padding(.horizontal, 12)
                .foregroundColor(.versalTextBlack)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(isContentNotValid() ? Color.red : (isFocused ? .versalPrimary500 : .versalGray100), lineWidth: 1))
                .font(.system(size: 12))
                .accentColor(.versalGray100)

            if isContentNotValid() {
                Label(errorText, image: "ic_error")
                    .padding(.top, 8)
                    .font(.system(size: 12))
                    .foregroundColor(.versalError500)
            }
        }
    }

    // MARK: Private
    private func isContentNotValid() -> Bool {
        if isNotValid, !text.isEmpty {
            return true
        } else {
            return false
        }
    }
}
