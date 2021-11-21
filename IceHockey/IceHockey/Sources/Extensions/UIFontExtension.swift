//
//  Fonts.swift
//  Places
//
//  Created by  Buxlan on 6/6/21.
//

import UIKit

extension UIFont {
    
    static let bxControlTitle: UIFont = .preferredFont(forTextStyle: .title1)
    static let bxCaption: UIFont = .preferredFont(forTextStyle: .subheadline)
    static let bxTitle3: UIFont = .regularFont17
    static let bxBody: UIFont = .lightFont17
    static let bxSubhead: UIFont = .lightFont12
    static let bxAppTitle: UIFont = .preferredFont(forTextStyle: .title1)
    
    static let lightFont12: UIFont = FontFamily.Roboto.light.font(size: 12)
    static let lightFont17: UIFont = FontFamily.Roboto.light.font(size: 17)
    
    static let regularFont12: UIFont = FontFamily.Roboto.regular.font(size: 12)
    static let regularFont15: UIFont = FontFamily.Roboto.regular.font(size: 15)
    static let regularFont17: UIFont = FontFamily.Roboto.regular.font(size: 17)
    static let regularFont50: UIFont = FontFamily.Roboto.regular.font(size: 50)
    
    static let boldFont17: UIFont = FontFamily.Roboto.bold.font(size: 17)   
        
}
