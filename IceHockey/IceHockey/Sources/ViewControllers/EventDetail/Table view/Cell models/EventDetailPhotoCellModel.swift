//
//  EventDetailPhotoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

struct EventDetailPhotoCellModel {
    
    var images: [ImageData]
    var likesInfo: EventLikesInfo
    var viewsInfo: EventViewsInfo
    var backgroundColor = Asset.other3.color
    var tintColor = Asset.other0.color
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
    init(event: SportNews) {
        images = event.images
        likesInfo = event.likesInfo
        viewsInfo = event.viewsInfo
    }
    
}
