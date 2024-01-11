//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

// MARK: - Validation Conforming Rules
public enum FormValidError: Error {
    case confirmPassword(password: String?)
    case empty(name: String)
    case hasNumbers
    case hasLowercase
    case hasUppercase
    case maximumLength(name: String, length: Int)
    case minimumLengthAccountNumber(name: String, length: Int)
    case minimumLengthPassword(name: String, length: Int)
    case minimumLengthRoutingNumber(name: String, length: Int)
    case requiredWhenExisting(name: String)
    case unknown
    case validEmail
}

extension FormValidError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .confirmPassword: return "\(L10N.get(.validation(.confirmPassword)))"
        case .empty: return "\(L10N.get(.validation(.fieldRequired)))"
        case .hasNumbers: return "\(L10N.get(.validation(.passwordNotSecure)))"
        case .hasLowercase: return "\(L10N.get(.validation(.passwordNotSecure)))"
        case .hasUppercase: return "\(L10N.get(.validation(.passwordNotSecure)))"
        case let .maximumLength(_, length): return "\(L10N.get(.validation(.maximumLength)))\(length)"
        case let .minimumLengthAccountNumber(_, length): return "\(L10N.get(.validation(.minimumLength)))\(length)"
        case .minimumLengthPassword: return "\(L10N.get(.validation(.passwordNotSecure)))"
        case let .minimumLengthRoutingNumber(_, length): return "\(L10N.get(.validation(.minimumLength)))\(length)"
        case .requiredWhenExisting: return "\(L10N.get(.validation(.fieldRequired)))"
        case .unknown: return "\(L10N.get(.validation(.unknownValidation)))"
        case .validEmail: return "\(L10N.get(.validation(.validEmailAddress)))"
        }
    }
}

// MARK: - Validation Length Limiter
public enum LengthConstants {
    static let MaximumLengthAccountNumber = 11
    static let MaximumLengthEmail = 35
    static let MaximumLengthMessage = 500
    static let MaximumLengthName = 30
    static let MaximumLengthNumber = 14
    static let MaximumLengthPassword = 100
    static let MaximumLengthRoutingNumber = 11
    static let MaximumLengthSocialSecurityNumber = 12
    static let MaximumLengthText = 50
    static let MaximumLengthTextview = 500
    static let MaximumLengthUSAPhoneNumber = 12
    static let MinimumLengthAccountNumber = 9
    static let MinimumLengthName = 3
    static let MinimumLengthNumber = 9
    static let MinimumLengthPassword = 8
    static let MinimumLengthRoutingNumber = 9
}
