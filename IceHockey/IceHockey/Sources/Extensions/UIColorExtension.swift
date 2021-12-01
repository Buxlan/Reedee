//
//  Colors.swift
//  Places
//
//  Created by  Buxlan on 6/4/21.
//

import UIKit

extension UIColor {
        
//    static let highlightedLabel = UIColor.label.withAlphaComponent(0.8)
    
    var highlighted: UIColor { withAlphaComponent(0.8) }
    
    @available(iOS 12.0, *)
    static let label: UIColor = .black
    
    @available(iOS 12.0, *)
    static let secondaryLabel: UIColor = Asset.other0.color
    
    static let highlightedLabel = UIColor.label.withAlphaComponent(0.8)
    
    static let systemBackground: UIColor = Asset.other3.color
    static let secondarySystemBackground: UIColor = Asset.other1.color
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { [weak self] rendererContext in
            self?.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    var codableColor: CodableColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let codableColor = CodableColor(red: red, green: green, blue: blue, alpha: alpha)
        return codableColor
    }
}
