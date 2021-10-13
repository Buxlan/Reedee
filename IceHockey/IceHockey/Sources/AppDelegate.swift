//
//  AppDelegate.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController = AppController()
    var authManager: AuthManager?
    var coordinator: ViewControllerCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        prepareWindow()
        
        prepareFirstLaunch()
        
        configureAppearance()
        
        authManager = AuthManager()
        authManager?.signInAnonymously()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    private func prepareWindow() {
        let navigationController = UINavigationController()
        coordinator = MainViewControllerCoordinator(navigationController: navigationController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func prepareFirstLaunch() {
        
    }
    
    private func configureAppearance() {
        UITabBar.appearance().backgroundColor = Asset.other1.color
        UITabBar.appearance().unselectedItemTintColor = Asset.other0.color
        UITabBar.appearance().tintColor = Asset.other0.color
        UINavigationBar.appearance().backgroundColor = Asset.accent1.color
        UINavigationBar.appearance().tintColor = Asset.main0.color
        UINavigationBar.appearance().barTintColor = Asset.other1.color
        
        let attr = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr, for: .selected)
        let attr2 = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attr2, for: .normal)
        
        window?.tintColor = Asset.other0.color
        
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(PlaceUser.unsignedUser) {
//            UserDefaults.standard.register(defaults:
//                                            [UserDefaultKey.loggedUser.rawValue: data])
//        }
    }
    
    private func signIn() {
        authManager?.signInAnonymously()
    }
    
}
