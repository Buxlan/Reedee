//
//  MainCoordinatorDelegate.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

import UIKit

protocol MainCoordinatorDelegate: UITabBarController {
    func switchTab(at index: Int)
    func tabsWasUpdated(_ newViewControllers: [UIViewController]?)    
}
