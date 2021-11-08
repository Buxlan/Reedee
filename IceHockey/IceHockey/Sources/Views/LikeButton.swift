//
//  LikeButton.swift
//  IceHockey
//
//  Created by  Buxlan on 11/7/21.
//

import UIKit

class LikeButton: UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.accessibilityIdentifier = "likeButton"
        let image = Asset.heart.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        let selectedImage = Asset.heartFill.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        self.tintColor = Asset.accent1.color
        self.isSelected = true
        self.contentMode = .scaleAspectFit
        self.imageView?.contentMode = .scaleAspectFit
        self.setTitleColor(Asset.textColor.color, for: .selected)
        self.setImage(image, for: .selected)
        self.setImage(selectedImage, for: .selected)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 24)
        self.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
