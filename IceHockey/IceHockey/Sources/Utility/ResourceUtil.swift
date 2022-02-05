//
//  ResourceUtil.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

class ResourceUtil: NSObject {

    public static func getRegularFont(_ size: CGFloat) -> UIFont {
        return FontFamily.Roboto.regular.font(size: size)
    }

    public static func getMediumFont(_ size: CGFloat) -> UIFont {
        return FontFamily.Roboto.medium.font(size: size)
    }

    public static func getBoldFont(_ size: CGFloat) -> UIFont {
        return FontFamily.Roboto.bold.font(size: size)
    }
}
