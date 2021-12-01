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

struct EventLikesInfoImpl: EventLikesInfo {
    
    static let empty = Self(count: 0, isLiked: false)
    var count: Int
    var isLiked: Bool
    
    init(databaseData: LikeDatabaseFlowData) {
        count = databaseData.count
        isLiked = databaseData.isLiked
    }
    
    private init(count: Int, isLiked: Bool) {
        self.count = count
        self.isLiked = isLiked
    }
    
}
