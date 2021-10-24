//
//  EditEventPhotoCollectionCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/23/21.
//

import UIKit

class EditEventPhotoCollectionCell: UICollectionViewCell, ConfigurableActionCell {
    
    // MARK: - Properties
    
    typealias DataType = String
    typealias HandlerType = EditEventHandler
    
    private var handler: HandlerType?
    private var imageName: String?
    
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
        return view
    }()
    
    private lazy var actionButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "actionButton (collection cell)"
        view.backgroundColor = Asset.other3.color
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.layer.borderColor = Asset.other0.color.cgColor
        view.layer.borderWidth = 0.5
        let image = Asset.xmark.image
        view.setImage(image, for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
        return view
    }()
    
    func configureInterface() {
        if isInterfaceConfigured { return }
        tintColor = UIColor.black
        backgroundColor = Asset.other3.color
                
        contentView.addSubview(dataImageView)
        contentView.addSubview(actionButton)
        configureConstraints()
        
        actionButton.addTarget(self, action: #selector(deleteHandle), for: .touchUpInside)
        
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            dataImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dataImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -24),
            dataImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -24),
            
            actionButton.centerXAnchor.constraint(equalTo: dataImageView.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: dataImageView.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 36),
            actionButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Helper functions
    
    func configure(with data: DataType, handler: HandlerType) {
        configureInterface()
        self.handler = handler
        self.imageName = data
        if dataImageView.image == nil {
            NetworkManager.shared.getImage(withName: data) { (image) in
                self.dataImageView.image = image
            }
        }
    }
}

extension EditEventPhotoCollectionCell {
    
    @objc private func deleteHandle() {
        if let imageName = imageName {
            handler?.deleteImage(withName: imageName)
        }
    }
    
}
