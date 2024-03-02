//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SecureTextField: View {
    // MARK: Internal

    // MARK: - Properties
    @FocusState var isFocused: Bool
    @Binding var text: String
    let placeHolder: String?
    let title: String

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) { // swiftlint:disable:this closure_body_length
            TextStyles.textFieldTitle(Text(title))
                .padding(.bottom, 8)

            ZStack(alignment: .trailing) {
                if isSecured {
                    TextStyles.textField(SecureField(placeHolder ?? title, text: $text)
                        .onChange(of: text) { _ in }
                        .focused($isFocused))
                        .modifier(DefaultTextFieldModifier(placeHolder: placeHolder ?? title,
                                                           text: $text,
                                                           isFocused: $isFocused,
                                                           isContentNotValid: { false },
                                                           keyboardType: .default,
                                                           autoCapitalizationType: UITextAutocapitalizationType.none))
                } else {
                    TextStyles.textField(TextField(placeHolder ?? title, text: $text))
                        .focused($isFocused)
                        .modifier(DefaultTextFieldModifier(placeHolder: placeHolder ?? title,
                                                           text: $text,
                                                           isFocused: $isFocused,
                                                           isContentNotValid: { false },
                                                           keyboardType: .default,
                                                           autoCapitalizationType: UITextAutocapitalizationType.none))
                }

                Button(action: {
                    isSecured.toggle()
                }, label: {
                    Image(isSecured ? ImageResource.icEyeOff : ImageResource.icEye)
                        .accentColor(.versalGray100)
                })
                .padding(.trailing)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }

    // MARK: Private
    @State private var isSecured = true
}
