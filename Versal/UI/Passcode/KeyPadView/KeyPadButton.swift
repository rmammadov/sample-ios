//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct KeyPadButton: View {
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }

    var key: String

    @Environment(\.keyPadButtonAction) var action: (String) -> Void

    var body: some View {
        Button(action: { action(key) }, label: {
            Color.clear
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(.versalPrimary500))
                .overlay(TextStyles.keyPadButtonTitle(Text(key)))
                .opacity(key == "." ? 0.0 : 1.0)
        })
    }
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

#Preview {
    KeyPadButton(key: "0")
        .padding()
        .frame(width: 80, height: 80)
        .previewLayout(.sizeThatFits)
}
