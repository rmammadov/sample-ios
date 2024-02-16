//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SolidRoundedButton: View {
    var isEnabled: Bool
    var title: String
    var onClick: () -> Void

    var body: some View {
        Button(action: onClick, label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .font(Font.headline.weight(.medium))
        })
        .buttonStyle(RoundedButtonStyle(backgroundColor: .versalPrimary500, backgroundColorDisabled: .versalGray200, cornerRadius: 8, isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}

struct RoundedButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let backgroundColorDisabled: Color
    let cornerRadius: CGFloat
    let isEnabled: Bool

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
