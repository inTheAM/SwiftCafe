//
//  Keychain.swift
//  SwiftCafe
//
//  Created by Ahmed Mgua on 18/11/2021.
//

import Foundation
import Security

enum Keychain {
  @discardableResult
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
  static func delete(key: String) -> OSStatus {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: key
    ] as [CFString: Any]

    return SecItemDelete(query as CFDictionary)
  }

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
