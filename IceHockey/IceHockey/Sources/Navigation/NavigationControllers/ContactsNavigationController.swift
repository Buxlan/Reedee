//
//  ContactsNavigationController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

import UIKit

class ContactsNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configureTabBarItem()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configureTabBarItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTabBarItem() {
        tabBarItem.title = L10n.TabBar.contacts
        tabBarItem.image = Asset.contacts.image
            .resizeImage(to: 24, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        tabBarItem.selectedImage = Asset.contacts.image
            .resizeImage(to: 24, aspectRatio: .current)
            .withRenderingMode(.alwaysOriginal)
    }
    
}
