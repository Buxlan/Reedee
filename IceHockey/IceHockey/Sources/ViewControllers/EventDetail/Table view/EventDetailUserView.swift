//
//  EventDetailUserCell.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/11/21.
//

import UIKit
import FirebaseStorageUI

class EventDetailUserView: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = EventDetailUserCellModel
    var data: DataType?
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    let imageHeight: CGFloat = 160.0
    let userImageHeight: CGFloat = 40.0
    
    private lazy var userImageView: UIImageView = {
        let cornerRadius: CGFloat = 20.0
        let view = UIImageView()
        view.accessibilityIdentifier = "userImageView"
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "usernameLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = .regularFont16
        return view
    }()
    
    private lazy var placeholderImage: UIImage = {
        Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    private lazy var noImage: UIImage = {
        Asset.noImage256.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel (table cell)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.font = .boldFont16
        return view
    }()
    
    // MARK: - Lifecircle
    
    override func prepareForReuse() {
        userImageView.image = nil
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(typeLabel)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let heightConstraint = userImageView.heightAnchor.constraint(equalToConstant: userImageHeight)
        heightConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: typeLabel.leadingAnchor, constant: -8),
            usernameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeLabel.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 4),
            typeLabel.heightAnchor.constraint(equalTo: userImageView.heightAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension EventDetailUserView: ConfigurableCollectionContent {
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        contentView.backgroundColor = data.backgroundColor
        
        typeLabel.backgroundColor = data.type.backgroundColor
        typeLabel.textColor = data.type.textColor
        typeLabel.text = data.type.description
        
        usernameLabel.backgroundColor = data.backgroundColor
        userImageView.backgroundColor = data.backgroundColor
        usernameLabel.textColor = data.textColor
                
        if !data.author.isEmpty {
            SportUser.getObject(by: data.author) { (user) in
                guard let user = user else {
                    return
                }
                self.usernameLabel.text = user.displayName
                let path = "users"
                ImagesManager.shared.getImage(withID: user.imageID, path: path) { [weak self] (image) in
                    guard let self = self else { return }
                    if let image = image {
                        self.userImageView.image = image
                    } else {
                        self.userImageView.image = self.noImage
                    }
                }
            }            
        }
        
    }
}
