//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

public struct PasscodeField: View {
    // MARK: Public
    public var body: some View {
        VStack(spacing: 30) {
            ZStack {
                pinDots
            }
        }
    }

    // MARK: Internal
    var keyWasTyped: () -> Void
    var maxDigits: Int = 4
    @Binding var passcode: String

    // MARK: Private
    private var pinDots: some View {
        HStack {
            Spacer()
            ForEach(0 ..< maxDigits, id: \.self) { index in
                Image(systemName: getImageName(at: index))
                    .font(.system(size: 30, weight: .thin, design: .default))
                    .foregroundColor(.primary500)
                Spacer()
            }
        }
    }

    private func getImageName(at index: Int) -> String {
        if index >= passcode.count {
            return "circle"
        }

        return "circle.fill"
    }
}
