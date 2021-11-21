//
//  LikeButton.swift
//  IceHockey
//
//  Created by  Buxlan on 11/7/21.
//

import UIKit

protocol LikeButtonModel {
    var textColor: UIColor { get set }
    var count: Int { get set }
}

struct DefaultLikeButtonModel: LikeButtonModel {
    var textColor: UIColor = Asset.textColor.color
    var count: Int = 0
}

struct LikeButtonModelImpl: LikeButtonModel {
    var textColor: UIColor
    var count: Int
}

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
        self.contentMode = .scaleAspectFit
        self.imageView?.contentMode = .scaleAspectFit
        self.setImage(image, for: .normal)
        self.setImage(selectedImage, for: .selected)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 24)
        self.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        self.titleLabel?.font = .boldFont17
        
        self.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        configure(with: DefaultLikeButtonModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LikeButton {
    
    func configure(with data: LikeButtonModel) {
        tintColor = getTintColor()
        setTitle("\(data.count)", for: .normal)
        setTitle("\(data.count)", for: .selected)
        setTitleColor(data.textColor, for: .normal)
        setTitleColor(data.textColor, for: .selected)
    }
    
    private func getTintColor() -> UIColor {
        return isSelected ? Asset.accent0.color : Asset.other0.color
    }
    
}
