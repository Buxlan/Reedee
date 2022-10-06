//
//  AppDelegate.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import UIKit
import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate lazy var coordinator: Coordinatable = self.makeCoordinator()
    
    var rootController: UINavigationController = {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        return navController
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
//        Session.isAppLoaded = false
        
        prepareWindow()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        configureAppearance()
        
        coordinator.start()
                
        let authManager = AuthManager.shared
        Auth.auth().addStateDidChangeListener(authManager.authStateListener)
        
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
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
}

extension AppDelegate {
    
    private func prepareWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
    }
    
    private func configureAppearance() {
        
        UITabBar.appearance().backgroundColor = Asset.other2.color
        UITabBar.appearance().unselectedItemTintColor = Asset.other0.color
        UITabBar.appearance().tintColor = Asset.other0.color
        UITabBar.appearance().barTintColor = Asset.other2.color
        
        let attrNormal = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attrNormal, for: .normal)
        let attrSelected = [NSAttributedString.Key.foregroundColor: Asset.other0.color]
        UITabBarItem.appearance().setTitleTextAttributes(attrSelected, for: .selected)
        
        let attrLight = [NSAttributedString.Key.foregroundColor: Asset.other3.color]
        
        UINavigationBar.appearance().backgroundColor = Asset.accent1.color
        UINavigationBar.appearance().tintColor = Asset.other3.color
        UINavigationBar.appearance().barTintColor = Asset.accent1.color
        UINavigationBar.appearance().titleTextAttributes = attrLight
        
//        if #available(iOS 13, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = Asset.accent1.color
////            appearance.tintColor = Asset.other3.color
////            appearance.barTintColor = Asset.accent1.color
//            appearance.titleTextAttributes = attrLight
//            appearance.configureWithOpaqueBackground()
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        }
        
    }
    
}

// MARK: - Private methods
private extension AppDelegate {
    func makeCoordinator() -> Coordinatable {
        let router = Router(rootController: rootController)
        let factory = CoordinatorFactory()
        return AppCoordinator(router: router, factory: factory)
    }
}
