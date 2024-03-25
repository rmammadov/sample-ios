//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Promises

public class Coordinator {
    // MARK: Lifecycle
    init() throws {
        self.db = DatabaseManager.instance()!
    }

    // MARK: Public
    public static func instance() -> Coordinator? {
        if singleton == nil {
            singleton = try? Coordinator()
        }
        return singleton
    }
    
    public func login(_ loginPayload: LoginPayload) {

    }

    public func logout() {
 
    }
    
    // MARK: Private
    private static var singleton: Coordinator?
    private let db: DatabaseManager
}
