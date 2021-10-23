//
//  EditEventPhotoCollectionCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit

class EditEventPhotoCollectionCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - Properties
    typealias DataType = UIImage
    
    internal var isInterfaceConfigured: Bool = false
    let imageAspectRate: CGFloat = 1.77
    let imageHeight: CGFloat = 160
        
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "actionEventButton (collection cell)"
        view.backgroundColor = Asset.other3.color
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderColor = Asset.other0.color.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        return view
    }()
    
    func configureInterface() {
        if isInterfaceConfigured { return }
        tintColor = UIColor.black
        backgroundColor = Asset.other3.color
        contentView.clipsToBounds = true
        
        contentView.addSubview(actionButton)
        contentView.addSubview(dataImageView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataImageView.heightAnchor.constraint(equalTo: dataImageView.widthAnchor, multiplier: 0.7),
            dataImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            actionButton.centerXAnchor.constraint(equalTo: dataImageView.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: dataImageView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 32),
            actionButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Helper functions
    
    func configure(with data: DataType) {
        configureInterface()
        dataImageView.image = data        
    }
}
