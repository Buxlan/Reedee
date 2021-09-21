//
//  ScaleAspectFitImageView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/19/21.
//

import UIKit

public class ScaleAspectFitImageView: UIImageView {
    /// constraint to maintain same aspect ratio as the image
    private var aspectRatioConstraint: NSLayoutConstraint?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public override init(image: UIImage!) {
        super.init(image: image)
        self.setup()
    }
    
    public override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.setup()
    }
    
    override public var image: UIImage? {
        didSet {
            self.updateAspectRatioConstraint()
            setNeedsUpdateConstraints()
        }
    }
    
    private func setup() {
        self.contentMode = .scaleAspectFit
        self.updateAspectRatioConstraint()
    }
    
    /// Removes any pre-existing aspect ratio constraint, and adds a new one based on the current image
    private func updateAspectRatioConstraint() {
        // remove any existing aspect ratio constraint
        if let constraint = self.aspectRatioConstraint {
            self.removeConstraint(constraint)
        }
        self.aspectRatioConstraint = nil
        
        if let imageSize = image?.size, imageSize.height != 0 {
            let aspectRatio = imageSize.width / imageSize.height
            let constraint = NSLayoutConstraint(item: self, attribute: .width,
                                                relatedBy: .equal,
                                                toItem: self, attribute: .height,
                                                multiplier: aspectRatio, constant: 0)
            // a priority above fitting size level and below low
            let priority = (UILayoutPriority.defaultLow.rawValue + UILayoutPriority.fittingSizeLevel.rawValue) / 2.0
            constraint.priority = UILayoutPriority.init(rawValue: priority)
            constraint.isActive = true
            self.addConstraint(constraint)
            self.aspectRatioConstraint = constraint
        }
    }
}
