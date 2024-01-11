//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

// https://sarunw.com/posts/how-to-parse-iso8601-date-in-swift/

public enum JSON {
    public static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = DateFormatter.iso8601.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        }
        return decoder
    }()

    public static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let dateString = DateFormatter.iso8601.string(from: date)
            try container.encode(dateString)
        }
        return encoder
    }()

    public static func convert<T: Encodable, U: Decodable>(_ value: T?, _ type: U.Type) -> U? {
        if let encoded = encode(value) { return decode(encoded, type) }
        return nil
    }

    public static func decode<T: Decodable>(_ value: Data?, _ type: T.Type) -> T? {
        if let value = value {
            return try? decoder.decode(type, from: value)
        }
        return nil
    }

    public static func decode<T: Decodable>(_ value: String?, _ type: T.Type) -> T? {
        return decode(value?.data(using: .utf8), type)
    }

    public static func encode<T: Encodable>(_ value: T?) -> String? {
        return try? encoder.encode(value).toString()
    }
}
