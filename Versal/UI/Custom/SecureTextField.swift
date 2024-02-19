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
            Text(title)
                .font(.system(size: 14))
                .font(Font.headline.weight(.medium))
                .padding(.bottom, 8)

            ZStack(alignment: .trailing) { // swiftlint:disable:this closure_body_length
                if isSecured {
                    SecureField(placeHolder ?? title, text: $text)
                        .font(.system(size: 12))
                        .accentColor(.versalGray100)
                        .foregroundColor(.versalTextBlack)
                        .frame(height: 40)
                        .padding(EdgeInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 42)))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? .versalPrimary500 : .versalGray100, lineWidth: 1))
                        .focused($isFocused)
                        .onChange(of: text) { _ in }
                } else {
                    TextField(placeHolder ?? title,
                              text: $text,
                              onEditingChanged: { _ in },
                              onCommit: {})
                        .font(.system(size: 12))
                        .accentColor(.versalGray100)
                        .foregroundColor(.versalTextBlack)
                        .frame(height: 40)
                        .padding(EdgeInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 42)))
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? .versalPrimary500 : .versalGray100, lineWidth: 1))
                        .focused($isFocused)
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
