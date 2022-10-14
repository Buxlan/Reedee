//
//  MainNavigationController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(false, animated: false)
        print("MainNavigationController viewDidLoad")
    }
    
}
