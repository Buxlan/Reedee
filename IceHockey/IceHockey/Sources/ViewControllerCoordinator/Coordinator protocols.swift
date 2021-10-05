//
//  Coordinator protocols.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import UIKit
import CoreFoundation

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: className, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: className)
                as? Self else {
            fatalError("Error: cannot find view controller")
        }
        return vc        
    }
    
}
