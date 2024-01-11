//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

extension Bundle {
    var applicationVersion: String {
        return "\(releaseVersion) (\(buildVersion))"
    }

    var buildVersion: String {
        return infoDictionary!["CFBundleVersion"] as! String // swiftlint:disable:this force_cast
    }

    var releaseVersion: String {
        return infoDictionary!["CFBundleShortVersionString"] as! String // swiftlint:disable:this force_cast
    }
}
