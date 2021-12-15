//
//  Keychain.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation
import Security

/// #Manages access to the Keychain storage on the user's device.
enum Keychain {
    @discardableResult
    /// Saves data to the keychain using the key provided
    /// - Parameters:
    ///   - key: The key to store the data.
    ///   - data: The data to store.
    /// - Returns: An integer representing the OSStatus of the save action.
  static func save(key: String, data: String) -> OSStatus {
    let bytes: [UInt8] = .init(data.utf8)
    let bytesAsData = Data(bytes)
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key,
      kSecValueData: bytesAsData
    ] as [CFString: Any]

    SecItemDelete(query as CFDictionary)

    return SecItemAdd(query as CFDictionary, nil)
  }

    @discardableResult
    /// Deletes data stored under the provided key from the keychain.
    /// - Parameter key: The key for the data to delete.
    /// - Returns: An integer representing the OSStatus of the delete action.
  static func delete(key: String) -> OSStatus {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key
    ] as [CFString: Any]

    return SecItemDelete(query as CFDictionary)
  }

    /// Loads the data stored under the provided key and decodes it into a String.
    /// - Parameter key: The key for the data to load.
    /// - Returns: An optional decoded String from the data stored under the provided key.
  static func load(key: String) -> String? {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key,
      kSecReturnData: kCFBooleanTrue as Any,
      kSecMatchLimit: kSecMatchLimitOne
    ] as [CFString: Any]

    var dataTypeRef: AnyObject?

    let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    if status == noErr {
      guard let data = dataTypeRef as? Data else {
        return nil
      }
      return String(decoding: data, as: UTF8.self)
    } else {
      return nil
    }
  }
}
