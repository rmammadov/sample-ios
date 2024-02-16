//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SecureTextField: View {
    // MARK: Internal
    let placeHolder: String
    let title: String

    @FocusState var isFocused: Bool
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) { // swiftlint:disable:this closure_body_length
            Text(title)
                .padding(.bottom, 8)
                .font(.system(size: 14))
                .font(Font.headline.weight(.medium))

            ZStack(alignment: .trailing) { // swiftlint:disable:this closure_body_length
                if isSecured {
                    SecureField(placeHolder, text: $text)
                        .focused($isFocused)
                        .frame(height: 40)
                        .onSubmit {}
                        .padding(EdgeInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 42)))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? .versalPrimary500 : .versalGray100, lineWidth: 1))
                        .foregroundColor(.versalTextBlack)
                        .font(.system(size: 12))
                        .accentColor(.versalGray100)
                        .onChange(of: text) { _ in
                        }
                } else {
                    TextField(placeHolder,
                              text: $text,
                              onEditingChanged: { _ in },
                              onCommit: {})
                        .focused($isFocused)
                        .frame(height: 40)
                        .padding(EdgeInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 42)))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? .versalPrimary500 : .versalGray100, lineWidth: 1))
                        .foregroundColor(.versalTextBlack)
                        .font(.system(size: 12))
                        .accentColor(.versalGray100)
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
    }

    // MARK: Private
    @State private var isSecured = true
}
