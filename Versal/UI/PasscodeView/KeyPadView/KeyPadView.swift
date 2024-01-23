//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct KeyPadView: View {
    // MARK: Internal
    @Binding var string: String
    var keyWasPressed: () -> Void

    var body: some View {
        VStack(alignment: .trailing) {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: ["0", "⌫"])
        }.environment(\.keyPadButtonAction, keyWasPressed(_:))
    }

    // MARK: Private
    private func keyWasPressed(_ key: String) {
        switch key {
        case "⌫":
            if !string.isEmpty {
                string.removeLast()
            }
        default: string += key
        }

        keyWasPressed()
    }
}
