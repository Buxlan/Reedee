//
//  TokenUtil.swift
//  TMKTitanFramework
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.07.2022.
//

import Foundation

struct TokenUtil {
    
    // MARK: - Setters
        
    static func clearAuthTokens() {
        RDKeyChainKey.allCases.forEach {
            switch $0 {
            case .deviceId, .sessionId:
                return
            default:
                setToken($0, nil)
            }
        }
    }
    
    // Common method to set token to store
    public static func setToken(_ key: RDKeyChainKey, _ token: String?) {
        var _: Data? = nil
        if let data = token?.data(using: .utf8) {
            RDKeyChain.save(key: key, data: data)
        } else {
            RDKeyChain.delete(key: key)
        }
    }
    
    // MARK: - Getters
    
    // Common method to get token from store
    public static func getToken(key: RDKeyChainKey) -> String? {
        if let data = RDKeyChain.load(key: key) {
            return String(data: data, encoding: .utf8)
        }

        return nil
    }
    
    public static func getLoginToken() -> String? {
        getToken(key: .loginToken)
    }
    
    public static func getAccessToken() -> String? {
        getToken(key: .accessToken)
    }
    
    public static func getPushToken() -> String? {
        getToken(key: .pushToken)
    }
    
    public static func getVoipToken() -> String? {
        getToken(key: .voipToken)
    }
    
    public static func getDeviceId() -> String {
        if let token = getToken(key: .deviceId) {
            return token
        }
        
        if let voipToken = TokenUtil.getVoipToken() {
            log.warning("TokenUtil Device id taken from voip token!!!")
            setToken(.deviceId, voipToken)
            return voipToken
        }
        
        log.warning("TokenUtil device id in nil, taken from UUID!!!")
        let uuid = UUID().uuidString
        setToken(.deviceId, uuid)
        
        return uuid
    }
    
    static func getNewTokenExpiresIn(from date: Date, _ expiresIn: Int) -> Int {
        let interval = Int(date.timeIntervalSince1970)
        
        return expiresIn + interval
    }
    
}
