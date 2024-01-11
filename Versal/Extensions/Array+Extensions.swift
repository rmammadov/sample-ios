//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        return uniqued { $0 }
    }

    func uniqued<T: Hashable>(_ mapper: @escaping (Element) -> T) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert(mapper($0)).inserted }
    }
}
