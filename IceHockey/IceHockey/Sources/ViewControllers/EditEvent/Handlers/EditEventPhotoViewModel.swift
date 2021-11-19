//
//  EditEventPhotoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

struct EditEventPhotoCellModel {
     
    weak var collectionBase: CollectionViewBase?
    var backgroundColor = Asset.other3.color
    var tintColor = Asset.other0.color
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
}
