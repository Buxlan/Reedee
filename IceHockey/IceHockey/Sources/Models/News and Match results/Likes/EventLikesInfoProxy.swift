//
//  EventLikesInfoProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 12/1/21.
//

class EventLikesInfoProxy: EventLikesInfo {
    
    var object: EventLikesInfo?
    
    var count: Int {
        get {
            object?.count ?? 0
        }
        set {
            object?.count = newValue
        }
    }
    
    var isLiked: Bool {
        get {
            object?.isLiked ?? false
        }
        set {
            object?.isLiked = newValue
        }
    }
    
}
