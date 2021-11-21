//
//  TabBarViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit
import UserNotifications
import CoreGraphics

class MainTabBarViewController: UITabBarController {
    
    // MARK: - Properties
    private let viewModel = MainTabBarViewModel()
        
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = L10n.App.name
        delegate = self
        let items = viewModel.viewControllers
        setViewControllers(items, animated: false)
        viewModel.configureTabBarItems(tabBar.items)
        
        self.navigationController?.isNavigationBarHidden = false
        
        selectedIndex = 0
        if let item = tabBar.items?[selectedIndex] {
            self.tabBar(self.tabBar, didSelect: item)
        }
        configureBars()
    }
    
    // MARK: - Helper functions
    private func configureBars() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
}
// UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {     
    }
}
