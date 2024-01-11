//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public extension Date {
    func add(_ value: Int, _ component: Calendar.Component) -> Date {
        var components = DateComponents()
        components.setValue(value, for: component)
        return Calendar.current.date(byAdding: components, to: self)!
    }
}
