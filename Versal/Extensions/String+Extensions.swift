//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

extension String {
    func format(_ arguments: CVarArg...) -> String {
        return String(format: self, arguments: arguments)
    }

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(_ arguments: CVarArg...) -> String {
        return localized().format(arguments)
    }
}
