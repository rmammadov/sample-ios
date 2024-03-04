//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum TextStyles {
    static let errorMessage: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(.versalError500)
    }

    static let footerTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 10))
            .foregroundColor(.versalGray400)
    }

    static let initials: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 16))
            .foregroundColor(.versalWhite)
    }

    static let keyPadButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-SemiBold", size: 28))
            .foregroundColor(.versalPrimary500)
    }

    static let plainButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(.versalPrimary500)
    }

    static let settingsItemTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(.versalBlack)
    }

    static let settingsSectionHeader: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 10))
            .foregroundColor(.versalGray400)
    }

    static let settingsUserDetailsEmail: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(.versalGray400)
    }

    static let settingsUserDetailsName: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(.versalBlack)
    }

    static let solidButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(.versalWhite)
    }

    static let subtitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-SemiBold", size: 20))
            .foregroundColor(.versalBlack)
    }

    static let textFieldPlaceholder: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(.versalGray300)
    }

    static let textFieldTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(.versalBlack)
    }

    static let title: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 28))
            .foregroundColor(.versalBlack)
    }

    static func errorLabel<Label: View>(_ label: Label) -> some View {
        label
            .font(.custom("DMSans-Medium", size: 12))
            .foregroundColor(.versalError500)
    }

    static func footerLink<Label: View>(_ label: Label) -> some View {
        label
            .font(.custom("DMSans-Medium", size: 12))
            .foregroundColor(.versalGray400)
    }

    static func textField<TextField: View>(_ textField: TextField) -> some View {
        textField
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(.versalBlack)
    }
}
