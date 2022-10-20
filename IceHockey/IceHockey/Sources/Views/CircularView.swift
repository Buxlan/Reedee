//
//  CircularView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//
// Added zero commit

import UIKit

class CircularView: UIView {
    override func tintColorDidChange() {
        self.backgroundColor = tintColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    override var frame: CGRect {
        didSet {
            updateCornerRadius()
        }
    }
    
    private func updateCornerRadius() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
