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
        VStack {
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
            string.removeLast()
            if string.isEmpty { string = "0" }
        case _ where string == "0": string = key
        default: string += key
        }

        keyWasPressed()
    }
}
