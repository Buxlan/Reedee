//
//  CorneredImageView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

class CorneredImageView: UIImageView {
    
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    init(corners: UIRectCorner, radius: CGFloat) {
        self.corners = corners
        self.cornerRadius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: corners, radius: cornerRadius)
    }
    
}
