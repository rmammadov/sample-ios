//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

enum TextStyles {
    static let dialogBody: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 14))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let dialogTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 24))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let errorMessage: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(R.color.versalError500.color())
    }

    static let footerTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 10))
            .foregroundColor(R.color.versalGray400.color())
    }

    static let initials: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 16))
            .foregroundColor(R.color.versalWhite.color())
    }

    static let keyPadButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-SemiBold", size: 28))
            .foregroundColor(R.color.versalPrimary500.color())
    }

    static let plainButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalPrimary500.color())
    }

    static let settingsItemTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let settingsSectionHeader: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 10))
            .foregroundColor(R.color.versalGray400.color())
    }

    static let settingsUserDetailsEmail: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(R.color.versalGray400.color())
    }

    static let settingsUserDetailsName: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let solidButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalWhite.color())
    }

    static let subtitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-SemiBold", size: 20))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let textFieldPlaceholder: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(R.color.versalGray300.color())
    }

    static let textFieldTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let title: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 28))
            .foregroundColor(R.color.versalBlack.color())
    }

    static let transparentButtonTitle: (Text) -> Text = { text in
        text
            .font(.custom("DMSans-Medium", size: 14))
            .foregroundColor(R.color.versalPrimary500.color())
    }

    static func errorLabel<Label: View>(_ label: Label) -> some View {
        label
            .font(.custom("DMSans-Medium", size: 12))
            .foregroundColor(R.color.versalError500.color())
    }

    static func footerLink<Label: View>(_ label: Label) -> some View {
        label
            .font(.custom("DMSans-Medium", size: 12))
            .foregroundColor(R.color.versalGray400.color())
    }

    static func textField<TextField: View>(_ textField: TextField) -> some View {
        textField
            .font(.custom("DMSans-Regular", size: 12))
            .foregroundColor(R.color.versalBlack.color())
    }
}
