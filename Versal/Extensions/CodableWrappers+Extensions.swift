//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import CodableWrappers
import Foundation

public struct DecimalCoder: StaticCoder {
    public static func decode(from decoder: Decoder) throws -> Decimal {
        return try Decimal(string: String(from: decoder))!
    }

    public static func encode(value: Decimal, to encoder: Encoder) throws {
        try String(describing: value).encode(to: encoder)
    }
}

public typealias DecimalCoding = CodingUses<DecimalCoder>
