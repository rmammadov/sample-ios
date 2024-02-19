//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct ErrorMessage: View {
    // MARK: - Properties
    var message: String

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            Image(R.image.ic_warning)
            Text(message)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .foregroundColor(.versalError500)
        }
    }
}
