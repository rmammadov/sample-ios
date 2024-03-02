//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct ReturnButton: View {
    // MARK: - Properties
    var isEnabled = false
    var onClick: () -> Void
    var title: String

    // MARK: - Body
    var body: some View {
        Button(action: onClick, label: {
            HStack {
                Image(ImageResource.icReturn)
                    .accentColor(.versalPrimary500)

                TextStyles.plainButtonTitle(Text(title))
            }
        })
        .disabled(!isEnabled)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
