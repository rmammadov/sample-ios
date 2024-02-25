//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct UserInitialsView: View {
    // MARK: Internal

    // MARK: - Properties
    let firstName: String
    let lastName: String
    let image: Image?

    // MARK: - Body
    var body: some View {
        ZStack {
            BackgroundStyles.yellowBackground
                .cornerRadius(4)
                .frame(width: 40, height: 40)

            TextStyles.initials(Text(getInitials()))

            UserProfileImage(image: image)
        }
    }

    // MARK: Private
    private func getInitials() -> String {
        return String(firstName.prefix(1) + lastName.prefix(1)).uppercased()
    }
}
