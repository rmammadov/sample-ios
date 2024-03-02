//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public struct DefaultPlaceholderModifier: ViewModifier {
    // MARK: Public
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                TextStyles.textFieldPlaceholder(Text(placeholder))
                    .padding(.horizontal, 12)
            }
            content
                .foregroundColor(Color.white)
        }
    }

    // MARK: Internal
    var showPlaceHolder: Bool
    var placeholder: String
}
