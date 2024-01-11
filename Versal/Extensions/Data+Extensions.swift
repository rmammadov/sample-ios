//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

extension Data {
    public func getJSONFromData() -> [String: Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any] {
                return json
            }
        } catch let error as NSError {
            Log.error(error)
        }

        return nil
    }

    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
