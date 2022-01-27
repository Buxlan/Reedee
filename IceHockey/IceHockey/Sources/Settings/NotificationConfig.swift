//
//  NotificationConfig.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 23.01.2022.
//

import Foundation

enum NotificationReceiver: String, Codable {
    case email = "EMAIL"
    case sms = "SMS"
    case site = "SITE"
}

struct NotificationConfig {
    var id: Int
    var type: String
    var name: String
    var receivers: [NotificationReceiver]?
}
