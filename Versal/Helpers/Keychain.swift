//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import Foundation

public enum Keychain {
    // MARK: Public
    public enum Key: String, CaseIterable {
        case faceIDEnabled
        case passcode
        case passcodeEnabled
        case passphrase
        case opticIDEnabled
        case touchIDEnabled
        case userId
    }

    public static func get(_ key: Key) -> String? {
        let query: [String: Any] = [
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecAttrAccount as String: key.rawValue as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status != errSecItemNotFound else {
            return nil
        }

        guard status == errSecSuccess else {
            Log.warn("Keychain.get(\(key.rawValue)) failed with: \(SecCopyErrorMessageString(status, nil)!)")
            return nil
        }

        guard let data = item as? Data else {
            return nil
        }

        return String(decoding: data, as: UTF8.self)
    }

    public static func reset() {
        Key.allCases.forEach { if $0 != .passphrase { remove($0) } }
    }

    public static func set(_ key: Key, _ value: String?) {
        if value == nil {
            remove(key)
        } else if get(key) == nil {
            insert(key, value!)
        } else {
            update(key, value!)
        }
    }

    // MARK: Private
    private static func insert(_ key: Key, _ value: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: value.data(using: String.Encoding.utf8)!
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status != errSecDuplicateItem else {
            update(key, value)
            return
        }

        guard status == errSecSuccess else {
            Log.warn("Keychain.insert(\(key.rawValue)) failed with: \(SecCopyErrorMessageString(status, nil)!)")
            return
        }
    }

    private static func remove(_ key: Key) {
        let query: [String: Any] = [
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecAttrAccount as String: key.rawValue,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status != errSecItemNotFound else {
            return
        }

        guard status == errSecSuccess else {
            Log.warn("Keychain.remove(\(key.rawValue)) failed with: \(SecCopyErrorMessageString(status, nil)!)")
            return
        }
    }

    private static func update(_ key: Key, _ value: String) {
        let query: [String: Any] = [
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecAttrAccount as String: key.rawValue,
            kSecClass as String: kSecClassGenericPassword
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: value.data(using: String.Encoding.utf8)!
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)

        guard status != errSecItemNotFound else {
            insert(key, value)
            return
        }

        // Any status other than errSecSuccess indicates the
        // update operation failed.
        guard status == errSecSuccess else {
            Log.warn("Keychain.update(\(key.rawValue)) failed with: \(SecCopyErrorMessageString(status, nil)!)")
            return
        }
    }
}
