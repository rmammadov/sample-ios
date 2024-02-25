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
        TextStyles.title(Text(text))
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
