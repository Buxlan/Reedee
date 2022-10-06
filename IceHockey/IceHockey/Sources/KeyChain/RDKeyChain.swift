//
//  RDKeyChain.swift
//  Reedee
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.10.2022.
//

import UIKit

public class RDKeyChain  {
    
    static let queue = DispatchQueue(label: "ru.reedee.keychain", attributes: .concurrent)
    
    static let duplicateErrorCode = -25299

    public class func delete(key: RDKeyChainKey) {
        self.delete(key: key.rawValue)
    }
    
    public class func delete(key: String) {
        queue.async(flags: .barrier) {
            log.debug("trying to delete \(key)")
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : key] as [String : Any]
            
            SecItemDelete(query as CFDictionary)
        }
    }
    
    public class func save(key: RDKeyChainKey, data: Data) {
        return self.save(key: key.rawValue, data: data)
    }
    
    public class func load(key: RDKeyChainKey) -> Data? {
        return self.load(key: key.rawValue)
    }
    
    public class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        
        let swiftString: String = cfStr as String
        return swiftString
    }
    
    private class func save(key: String, data: Data) {
        queue.async(flags: .barrier) {
            log.debug("trying to save \(key)")
            
            let query = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : key,
                kSecAttrAccessible as String : kSecAttrAccessibleAlways as String,
                kSecValueData as String   : data ] as [String : Any]
            
            SecItemDelete(query as CFDictionary)
            
            var status = SecItemAdd(query as CFDictionary, nil)
            log.debug(status)
            if status == duplicateErrorCode {
                delete(key: key)
                log.debug("retry to save after removing old value")
                status = SecItemAdd(query as CFDictionary, nil)
                log.debug(status)
            }
        }
    }
    
    private class func load(key: String) -> Data? {
        var data: Data? = nil
        
        queue.sync(flags: .barrier) {
            log.debug("trying to load \(key)")
            let query = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrAccount as String : key,
                kSecReturnData as String  : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
            var dataTypeRef: AnyObject? = nil
            
            let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            
            if status == noErr {
                // swiftlint:disable force_cast
                data = dataTypeRef as! Data?
                // swiftlint:enable force_cast
            } else {
                log.debug("keychain load status == \(status)")
            }
        }
        
        return data
    }
}

public extension Data {
    
    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }
    
    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
}
