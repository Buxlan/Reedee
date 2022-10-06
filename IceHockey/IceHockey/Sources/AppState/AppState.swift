//
//  AppState.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation

struct AppState {
    static let isAppStarted = MonitoredState<Bool>.init(false, key: "isAppStarted")
    static let isFirstLaunch = UserDefaultsState<Bool>.init(true, key: "isFirstLaunch")
    static let isLoggedIn = UserDefaultsState<Bool>.init(false, key: "isLoggedIn")
    static let userId = UserDefaultsState<String>.init("undefined", key: "userId")
    static let systemSettings = UserDefaultsState<SystemSettings>.init(SystemSettings(), key: "systemSettings")
    static let notificationId = MonitoredState<String>.init(nil, key: "notificationId")
    static let notificationSettings = MonitoredState<([NotificationConfig],
                                                      [NotificationSetting])>.init(([], []),
                                                                                   key: "notificationSettings")
    static let isAccessToCameraGranted = MonitoredState<Bool>.init(false, key: "isAccessToCameraGranted")
    static let isAccessToMicGranted = MonitoredState<Bool>.init(false, key: "isAccessToMicGranted")
    static let phoneCodes = MonitoredState<[PhoneCode]>.init(nil, key: "phoneCodes")
    static let isSessionIdSaved = UserDefaultsState<Bool>.init(false, key: "isSessionIdSaved")
    static let currentUser = UserDefaultsState<Data?>.init(nil, key: "currentUser")
    static let fileTypesBlackList = UserDefaultsState<[String]>.init(nil, key: "fileTypesBlackList")
    static let isSeenOnboarding = UserDefaultsState<Bool>.init(false, key: "isSeenOnboarding")

    static func clearState() {
        userId.clear()
        isLoggedIn.modify(false)
        notificationSettings.modify(([], []))
        isSessionIdSaved.modify(false)
        currentUser.clear()
        fileTypesBlackList.clear()
    }
}

