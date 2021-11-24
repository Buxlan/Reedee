//
//  Like.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

protocol EventLikesInfo {
    var count: Int { get set }
    var isLiked: Bool { get set }
}

//struct EmptyEventLikesInfo: EventLikesInfo {
//    var count: Int = 0
//    var isLiked: Bool = false
//}

struct EventLikesInfoImpl: EventLikesInfo {
    static let empty = Self(count: 0, isLiked: false)
    var count: Int
    var isLiked: Bool
}
