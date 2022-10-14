//
//  NotificationName.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.10.2022.
//

import Foundation

enum NotificationName: String {
    case networkUnavailable
    case signInFailed
    
    var value: Notification.Name {
        .init(rawValue: self.rawValue)
    }
}
