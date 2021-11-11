//
//  KeyboardAccessoryPhotoView.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class KeyboardAccessoryPhotoView: UIView {
    
    // MARK: - Properties
        
    lazy var galleryButton: UIButton = {
        let offset: CGFloat = 8
        let frame = CGRect(x: offset, y: 0, width: 80, height: 44)
        let view = UIButton(frame: frame)
        view.accessibilityIdentifier = "galleryButton"
        view.backgroundColor = Asset.other0.color
        view.tintColor = Asset.other2.color
        let image = Asset.photo.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.titleLabel?.font = .boldFont16
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        return view
    }()
    
    lazy var cameraButton: UIButton = {
        let offset: CGFloat = 8
        let frame = CGRect(x: galleryButton.bounds.width + offset*2, y: 0, width: 80, height: 44)
        let view = UIButton(frame: frame)
        view.accessibilityIdentifier = "cameraButton"
        view.backgroundColor = Asset.other0.color
        view.tintColor = Asset.other2.color
        let image = Asset.camera.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.titleLabel?.font = .boldFont16
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let width = self.frame.width
        let frame = CGRect(x: width,
                           y: 0,
                           width: 100,
                           height: 44)
        let view = UIButton(frame: frame)
        view.accessibilityIdentifier = "doneButton"
        view.backgroundColor = Asset.other0.color
        view.tintColor = Asset.other0.color
        view.setTitle(L10n.Other.done, for: .normal)
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        view.titleLabel?.font = .boldFont18
        view.sizeToFit()
        view.frame = CGRect(x: width - view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: 44)
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Asset.other0.color
        self.addSubview(galleryButton)
        self.addSubview(doneButton)
        self.addSubview(cameraButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
}
