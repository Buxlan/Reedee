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
        vc = UINavigationController(rootViewController: LastNewsTableViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: HockeySquadsViewController())
        items.append(vc)
                
        vc = UINavigationController(rootViewController: ContactsViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: ShopShowcaseViewController())
        items.append(vc)
        
        return items
    }()
}
