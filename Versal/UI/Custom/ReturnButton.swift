//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct ReturnButton: View {
    var isEnabled = false
    var title: String
    var onClick: () -> Void

    var body: some View {
        Button(action: onClick, label: {
            HStack {
                Image(ImageResource.icReturn)
                    .accentColor(.versalPrimary500)

                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.versalPrimary500)
                    .font(Font.headline.weight(.medium))
            }
        })
        .disabled(!isEnabled)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
