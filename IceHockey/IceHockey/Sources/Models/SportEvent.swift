//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Foundation

protocol SportEvent {
    var uid: String { get set }
    var type: SportEventType { get set }
    init?(key: String, dict: [String: Any])
}
