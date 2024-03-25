//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct TransparentRoundedButton: View {
    // MARK: - Properties
    var isEnabled: Bool
    var onClick: () -> Void
    var title: String

    // MARK: - Body
    var body: some View {
        Button(action: onClick, label: {
            TextStyles.transparentButtonTitle(Text(title))
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(TransparentRoundedButtonStyle(backgroundColor: .versalPrimary50, backgroundColorDisabled: .versalGray200, cornerRadius: 8, isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

struct TransparentRoundedButtonStyle: ButtonStyle {
    // MARK: - Properties
    let backgroundColor: Color
    let backgroundColorDisabled: Color
    let cornerRadius: CGFloat
    let isEnabled: Bool

    // MARK: - Body
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Group {
                if isEnabled {
                    if configuration.isPressed {
                        backgroundColor.opacity(0.8) // Background when pressed
                    } else {
                        backgroundColor // Background color
                    }
                } else {
                    backgroundColorDisabled // Background when disabled
                }
            })
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .disabled(!isEnabled)
    }
}
