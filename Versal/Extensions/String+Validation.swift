//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

extension String {
    private static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#)

    func isValidEmail() -> Bool {
        return String.emailPredicate.evaluate(with: self)
    }
}
