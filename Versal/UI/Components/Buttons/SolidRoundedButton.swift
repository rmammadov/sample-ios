//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SolidRoundedButton: View {
    // MARK: - Properties
    var isEnabled: Bool
    var onClick: () -> Void
    var title: String

    // MARK: - Body
    var body: some View {
        Button(action: onClick, label: {
            TextStyles.solidButtonTitle(Text(title))
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(RoundedButtonStyle(backgroundColor: R.color.versalPrimary500.color(),
                                        backgroundColorDisabled: R.color.versalGray200.color(),
                                        cornerRadius: 8,
                                        isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

struct RoundedButtonStyle: ButtonStyle {
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
