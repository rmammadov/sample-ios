//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct VersalNavigationView<Content: View>: View {
    // MARK: Lifecycle
    init(isBackAvailable: Binding<Bool>,
         isTopBarAvailable: Bool = true,
         title: String? = nil,
         leadingButtonAction: (() -> Void)? = nil,
         leadingButtonIcon: String? = nil,
         trailingButtonAction: (() -> Void)? = nil,
         trailingButtonIcon: String? = nil,
         @ViewBuilder content: () -> Content) {
        self.isTopBarAvailable = isTopBarAvailable
        self.content = content()
        self.leadingButtonAction = leadingButtonAction
        self.leadingButtonIcon = leadingButtonIcon
        self.title = title
        self.trailingButtonAction = trailingButtonAction
        self.trailingButtonIcon = trailingButtonIcon
        _isBackAvailable = isBackAvailable
    }

    // MARK: Internal
    @Binding var isBackAvailable: Bool

    let content: Content
    let isTopBarAvailable: Bool
    let leadingButtonAction: (() -> Void)?
    let leadingButtonIcon: String?
    let title: String?
    let trailingButtonAction: (() -> Void)?
    let trailingButtonIcon: String?

    var body: some View {
        VStack(spacing: 0) {
            if isTopBarAvailable {
                HeaderContainer(isBackAvailable: $isBackAvailable,
                                title: title,
                                leadingButtonAction: leadingButtonAction,
                                leadingButtonIcon: leadingButtonIcon,
                                trailingButtonAction: trailingButtonAction,
                                trailingButtonIcon: trailingButtonIcon)
            }

            // Place the content inside a NavigationView
            NavigationView {
                content
            }
        }
    }
}
