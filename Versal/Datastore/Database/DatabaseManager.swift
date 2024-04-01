//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public class DatabaseManager {
    // MARK: Public
    public static func instance() -> DatabaseManager? {
        if singleton == nil {
            singleton = DatabaseManager()
        }
        return singleton
    }

    public func reset() {}

    // MARK: Private
    private static var singleton: DatabaseManager?
}
