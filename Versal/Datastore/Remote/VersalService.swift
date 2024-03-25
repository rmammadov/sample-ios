//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation
import Moya
import Then

public enum VersalService {
    public static let applicationVersion = Bundle.main.applicationVersion
    public static let platformType: Platform = UIDevice.current.userInterfaceIdiom == .pad ? .IOS_IPAD : .IOS_IPHONE
    public static let platformVersion = UIDevice.current.systemVersion
}
