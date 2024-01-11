//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

@discardableResult public func synchronized<T>(_ lock: AnyObject, _ closure: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try closure()
}

@discardableResult public func synchronized<T>(_ lock: AnyObject, _ counter: inout Int, _ closure: () throws -> T?) rethrows -> T? {
    objc_sync_enter(counter)
    if counter > 0 {
        objc_sync_exit(counter)
        return nil
    }
    counter = 1
    objc_sync_exit(counter)

    defer {
        objc_sync_enter(counter)
        counter = 0
        objc_sync_exit(counter)
    }

    return try synchronized(lock, closure)
}
