//
//  TabBarViewController.swift
//  Places
//
//  Created by  Buxlan on 5/26/21.
//

import UIKit
import UserNotifications
import CoreGraphics

class MainTabBarViewController: UITabBarController, MainViewProtocol {
    
    // MARK: - Properties
    
    var onCompletion: CompletionBlock?
    
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
        
        title = "L10n.App.name"
        delegate = self
        
        selectedIndex = 0
        if let item = tabBar.items?[selectedIndex] {
            self.tabBar(self.tabBar, didSelect: item)
        }
        configureBars()
    }
    
    // MARK: - Helper functions
    private func configureBars() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
}
// UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    
}

extension MainTabBarViewController: MainCoordinatorDelegate {
    func switchTab(at index: Int) {
        guard let count = viewControllers?.count,
              count >= index,
              selectedIndex != index
        else { return }
        selectedIndex = index
    }
    
    func tabsWasUpdated(_ newViewControllers: [UIViewController]?) {
        // Save selection
        let selectedTab = self.selectedIndex
        
        log.debug("MainViewController tabsWasUpdated start \(String(describing: newViewControllers))")
        setViewControllers(newViewControllers, animated: false)
        
        // Restore selection
        self.selectedIndex = selectedTab
    }
}
