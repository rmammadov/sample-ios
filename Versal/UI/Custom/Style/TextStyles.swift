//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum TextStyles {
    // Body text style
    static let body: (Text) -> Text = { text in
        text
            .font(.body)
            .foregroundColor(.black)
    }

    // Title style
    static let errorMessage: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalError500)
    }

    // Default textfield style
    static let defaultTextFieldPlaceholder: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalGray300)
    }

    // Footer title style
    static let footerTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    // Initials style
    static let initials: (Text) -> Text = { text in
        text
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.versalWhite)
    }

    // KeyPad button title style
    static let keyPadButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 28, weight: .semibold))
            .foregroundColor(.versalPrimary500)
    }

    // Plain button title style
    static let plainButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalPrimary500)
    }

    // Settings item title style
    static let settingsItemTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    // Settings section header style
    static let settingsSectionHeader: (Text) -> Text = { text in
        text
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    // Settings user email style
    static let settingsUserDetailsEmail: (Text) -> Text = { text in
        text
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalGray400)
    }

    // Settings user name style
    static let settingsUserDetailsName: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    // Solid button title style
    static let solidButtonTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.versalWhite)
    }

    // Subtitle style
    static let subtitle: (Text) -> Text = { text in
        text
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.versalBlack)
    }

    // TextField title style
    static let textFieldTitle: (Text) -> Text = { text in
        text
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(.versalBlack)
    }

    // Title style
    static let title: (Text) -> Text = { text in
        text
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(.versalBlack)
    }

    // Error label style
    static func errorLabel<Label: View>(_ label: Label) -> some View {
        label
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.versalError500)
    }

    // Default textfield style
    static func defaultTextField<TextField: View>(_ textField: TextField) -> some View {
        textField
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.versalBlack)
    }

    // Footer link style
    static func footerLink<Label: View>(_ label: Label) -> some View {
        label
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(.versalGray400)
    }
}
