//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum TextStyles {
    static let body: (Text) -> Text = { text in
        text
            .font(.body)
            .foregroundColor(.black)
    }

    static let errorMessage: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalError500)
    }

    static let footerTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    static let initials: (Text) -> Text = { text in
        text
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.versalWhite)
    }

    static let keyPadButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 28, weight: .semibold))
            .foregroundColor(.versalPrimary500)
    }

    static let plainButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalPrimary500)
    }

    static let settingsItemTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    static let settingsSectionHeader: (Text) -> Text = { text in
        text
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    static let settingsUserDetailsEmail: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    static let settingsUserDetailsName: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    static let solidButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalWhite)
    }

    static let subtitle: (Text) -> Text = { text in
        text
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.versalBlack)
    }

    static let textFieldPlaceholder: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalGray300)
    }

    static let textFieldTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(.versalBlack)
    }

    static let title: (Text) -> Text = { text in
        text
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    static func errorLabel<Label: View>(_ label: Label) -> some View {
        label
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.versalError500)
    }

    static func footerLink<Label: View>(_ label: Label) -> some View {
        label
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.versalGray400)
    }

    static func textField<TextField: View>(_ textField: TextField) -> some View {
        textField
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalBlack)
    }
}
