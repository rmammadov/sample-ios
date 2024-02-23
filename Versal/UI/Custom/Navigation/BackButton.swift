//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct BackButton: View {
    @Binding var isBackAvailable: Bool

    var body: some View {
        Button(action: {
            isBackAvailable = false
        }, label: {
            Image(R.image.ic_return)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        })
        .padding(.leading, 12)
    }
}
