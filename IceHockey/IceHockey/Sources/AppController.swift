//
//  AppController.swift
//  Places
//
//  Created by  Buxlan on 5/27/21.
//

import Foundation
import UIKit

class AppController: NSObject {
    
    // MARK: - Public
    static let shared = AppController()
    
    var authManager = AuthManager()
    
    struct Key {
        static let wasLaunchedBefore = "wasLauchedBefore"
        static let bundleVersion = "CFBundleVersion"
        static let lastExecutedBundleVersion = "LastExecutedBundleVersion"
    }
        
    var isFirstLaunch: Bool {
        get {
            if _isFirstLaunch {
                authManager.signInAnonymously()
            }
            return _isFirstLaunch
//            let value = UserDefaults.standard.bool(forKey: "wasLauchedBefore")
//            return !value
        }
        set {
            _isFirstLaunch = newValue
            UserDefaults.standard.set(!newValue, forKey: Key.wasLaunchedBefore)
        }
    }
    
    private var _isFirstLaunch = true
        
    override init() {
        super.init()
        
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: Key.bundleVersion)
        if let bundleVersion = bundleVersion as? String {
            let lastExecutedVersion = UserDefaults.standard.value(forKey: Key.lastExecutedBundleVersion)
            if let lastExecutedVersion = lastExecutedVersion as? String {
                if bundleVersion != lastExecutedVersion {
                    updateVersion(old: lastExecutedVersion, new: bundleVersion)
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func updateVersion(old: String, new: String) {
        Utils.log("updating version to ", object: new)
        UserDefaults.standard.set(new, forKey: Key.lastExecutedBundleVersion)
    }
    
}
