//
//  MainTabBarViewModel.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//
import UIKit

class MainTabBarViewModel {
    lazy var viewControllers: [UIViewController] = {
        var items = [UIViewController]()
        var vc: UINavigationController
        let rootVC = LastEventsTableViewController()
        rootVC.data = SportTeam(displayName: "Красные медведи", uuid: "Красные медведи", phoneNumber: "+7909555555", logoImageName: "logo")
        vc = UINavigationController(rootViewController: rootVC)
        items.append(vc)
        
        vc = UINavigationController(rootViewController: HockeySquadsViewController())
        items.append(vc)
                
        vc = UINavigationController(rootViewController: ContactsViewController())
        items.append(vc)
        
//        vc = UINavigationController(rootViewController: ShopShowcaseViewController())
//        items.append(vc)
        
        return items
    }()
}
