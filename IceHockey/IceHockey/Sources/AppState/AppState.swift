//
//  AppState.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation

struct AppState {
    public static let isAppStarted = MonitoredState<Bool>.init(false,
                                                               key: "isAppStarted")
    public static let isFirstLaunch = UserDefaultsState<Bool>.init(true,
                                                                   key: "isFirstLaunch")
    public static let isLoggedIn = UserDefaultsState<Bool>.init(false,
                                                                key: "isLoggedIn")
    public static let userId = UserDefaultsState<String>.init("undefined",
                                                              key: "userId")
    public static let systemSettings = UserDefaultsState<SystemSettings>.init(SystemSettings(),
                                                                              key: "systemSettings")
    public static let notificationId = MonitoredState<String>.init(nil,
                                                                   key: "notificationId")
    public static let notificationSettings = MonitoredState<([NotificationConfig],
                                                             [NotificationSetting])>.init(([], []),
                                                                                          key: "notificationSettings")
    public static let isAccessToCameraGranted = MonitoredState<Bool>.init(false,
                                                                          key: "isAccessToCameraGranted")
    public static let isAccessToMicGranted = MonitoredState<Bool>.init(false,
                                                                       key: "isAccessToMicGranted")
    public static let phoneCodes = MonitoredState<[PhoneCode]>.init(nil,
                                                                    key: "phoneCodes")
    public static let isSessionIdSaved = UserDefaultsState<Bool>.init(false,
                                                                      key: "isSessionIdSaved")
    public static let currentUser = UserDefaultsState<Data?>.init(nil,
                                                                          key: "currentUser")
    public static let fileTypesBlackList = UserDefaultsState<[String]>.init(nil,
                                                                            key: "fileTypesBlackList")

    static func clearState() {
        userId.clear()
        isLoggedIn.modify(false)
        notificationSettings.modify(([], []))
        isSessionIdSaved.modify(false)
        currentUser.clear()
        fileTypesBlackList.clear()
    }
}

