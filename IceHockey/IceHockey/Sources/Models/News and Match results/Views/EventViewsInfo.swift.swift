//
//  EventViewsInfo.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

import Foundation

protocol EventViewsInfo {
    
}

//struct EmptyEventViewsInfo: EventViewsInfo {
//
//}

struct EventViewsInfoImpl: EventViewsInfo {
    static let empty = Self()
}
