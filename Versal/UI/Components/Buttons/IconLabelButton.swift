//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import RswiftResources
import SwiftUI

struct IconLabelButton: View {
    // MARK: - Properties
    var image: RswiftResources.ImageResource
    var isEnabled: Bool
    var onClick: () -> Void
    var title: String

    // MARK: - Body
    var body: some View {
        Button(action: onClick, label: {
            HStack(alignment: VerticalAlignment.center, spacing: 0) {
                Image(image)
                    .frame(width: 18, height: 18)

                TextStyles.settingsItemTitle(Text(title))
                    .padding(.leading, 8)

                Spacer()
            }
            .padding(.vertical, 8)
        })
        .buttonStyle(RoundedButtonStyle(backgroundColor: BackgroundStyles.defaultColor, backgroundColorDisabled: R.color.versalGray200.color(),
                                        cornerRadius: 4,
                                        isEnabled: isEnabled))
        .disabled(!isEnabled)
    }
}
