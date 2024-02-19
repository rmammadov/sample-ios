//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct SectionTitle: View {
    // MARK: - Properties
    let text: String

    // MARK: - Body
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 28))
            .font(Font.headline.weight(.medium))
            .foregroundColor(.versalTextBlack)
    }
}
