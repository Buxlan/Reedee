//
//  EditEventAddPhotoCollectionCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit

class EditEventAddPhotoCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    typealias DataType = UIImage?
    
    internal var isInterfaceConfigured: Bool = false
    let imageAspectRate: CGFloat = 1
    let imageHeight: CGFloat = 80
    
    private lazy var actionButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "actionButton (collection cell)"
        view.backgroundColor = Asset.other1.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderColor = Asset.other0.color.cgColor
        view.layer.borderWidth = 0.5
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        let image = Asset.camera.image.resizeImage(to: 80, aspectRatio: .current).withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        return view
    }()
    
    func configureUI() {
        if isInterfaceConfigured { return }
        tintColor = UIColor.black
        backgroundColor = Asset.other3.color
        contentView.clipsToBounds = true
        contentView.addSubview(actionButton)
        configureConstraints()
        actionButton.addTarget(self, action: #selector(actionHandle), for: .touchUpInside)
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            actionButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -24),
            actionButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Helper functions
        
}

extension EditEventAddPhotoCollectionCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
    }
    
}

extension EditEventAddPhotoCollectionCell {
    
    @objc func actionHandle(_ sender: UIButton) {
//        handler?.openGallery()
    }
    
}
