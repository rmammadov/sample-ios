//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import UIKit

enum EnvType {
    case development
    case sandbox
    case production

    // MARK: Internal
    static var current: Self {
        #if PRODUCTION
            return .production
        #elseif SANDBOX
            return .sandbox
        #else
            return .development
        #endif
    }
}
