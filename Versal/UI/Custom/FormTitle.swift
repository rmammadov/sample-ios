//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct FormTitle: View {
    let text: String

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 28))
            .foregroundColor(.versalTextBlack)
            .font(Font.headline.weight(.medium))
    }
}
