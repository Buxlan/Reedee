//
//  ShadowView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/13/21.
//

import UIKit

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 0
        self.layer.shadowOffset = CGSize()
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = Asset.other0.color.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners,
                                             cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
