//
//  RDKeyChainKey.swift
//  Reedee
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.10.2022.
//

public enum RDKeyChainKey: String, CaseIterable {
    case sessionId
    case deviceId
    case loginToken
    case accessToken
    case refreshToken
    case accessTokenExpiresIn
    case refreshTokenExpiresIn
}
