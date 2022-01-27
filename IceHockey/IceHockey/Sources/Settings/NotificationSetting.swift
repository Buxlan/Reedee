//
//  NotificationSetting.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 23.01.2022.
//

struct NotificationSetting: Codable {
    
    var type: String
    var receiver: NotificationReceiver
    var userId: Int?

    init (type: String, receiver: NotificationReceiver, userId: Int? = nil) {
        self.type = type
        self.receiver = receiver
        self.userId = userId
    }
}
