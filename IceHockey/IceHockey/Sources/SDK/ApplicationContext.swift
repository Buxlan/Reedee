//
//  ApplicationContext.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation
import UIKit

enum SDKType {
    case redbears    
}

class ApplicationContext {
    var theme: AppTheme!
    var sdk: SDKType!
    weak var rootVC: UIViewController?
    var isExternalEnter: Bool = false
    var defaultLocale = Locale(identifier: "ru")

    public static let shared: ApplicationContext = ApplicationContext()
    
}

