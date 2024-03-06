//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct UserProfileImage: View {
    // MARK: - Properties
    var image: Image?

    // MARK: - Body
    var body: some View {
        Image("yourImageName")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(radius: 0)
    }
}
