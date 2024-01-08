//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Bugsnag
import Foundation

public enum Log {
    public static func breadcrumb(_ breadcrumb: String) {
        Bugsnag.leaveBreadcrumb(withMessage: breadcrumb)
    }

    public static func debug(_ message: Any) {
        #if DEBUG
            print(message)
        #endif
    }

    public static func error(_ error: Error) {
        Bugsnag.notifyError(error) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .error
            return true
        }
        debug(error.localizedDescription)
    }

    public static func error(_ exception: NSException) {
        Bugsnag.notify(exception) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .error
            return true
        }
        debug(exception.reason ?? "")
    }

    public static func error(_ reason: String) {
        let exception = NSException(name: NSExceptionName(rawValue: "NamedException"), reason: reason)
        Bugsnag.notify(exception) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .error
            return true
        }
        debug(reason)
    }

    public static func warn(_ error: Error) {
        Bugsnag.notifyError(error) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .warning
            return true
        }
        debug(error.localizedDescription)
    }

    public static func warn(_ exception: NSException) {
        Bugsnag.notify(exception) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .warning
            return true
        }
        debug(exception.reason ?? "")
    }

    public static func warn(_ reason: String) {
        let exception = NSException(name: NSExceptionName(rawValue: "NamedException"), reason: reason)
        Bugsnag.notify(exception) { event in
            event.errors[0].stacktrace.remove(at: 0)
            event.severity = .warning
            return true
        }
        debug(reason)
    }
}
