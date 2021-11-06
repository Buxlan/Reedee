//
//  EventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit
import FirebaseStorageUI

class EventTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = NewsTableCellModel
    var data: DataType?
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    let imageHeight: CGFloat = 160
    
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private lazy var placeholderImage: UIImage = {
        Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    private lazy var noImage: UIImage = {
        Asset.noImage256.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "dataLabel (table cell)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 5
        view.textAlignment = .left
        view.font = .regularFont14
        return view
    }()
    
    private lazy var dateLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "dateLabel (table cell)"
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .left
        view.font = .regularFont14
        return view
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
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "likeButton"
        view.addTarget(self, action: #selector(handleLikeAction), for: .touchUpInside)
        view.backgroundColor = contentView.backgroundColor
        let image = Asset.heart.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        let selectedImage = Asset.heartFill.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        view.tintColor = getLikeButtonTintColor(isSelected: false)
        view.contentMode = .scaleAspectFit
        view.imageView?.contentMode = .scaleAspectFit
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.setTitleColor(Asset.textColor.color, for: .selected)
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 24)
        view.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "shareButton"
        view.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
        view.backgroundColor = contentView.backgroundColor
        let image = Asset.share.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        view.tintColor = Asset.other0.color
        view.contentMode = .scaleAspectFit
        view.imageView?.contentMode = .scaleAspectFit
        
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecircle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dataImageView.image = nil
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(dataImageView)
        contentView.addSubview(dataLabel)
        contentView.addSubview(shadowView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(bottomBackgroundView)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(typeLabel)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.heightAnchor.constraint(equalTo: dataImageView.widthAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataLabel.topAnchor.constraint(equalTo: dataImageView.bottomAnchor, constant: 8),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: dataLabel.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -8),
            
            bottomBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBackgroundView.topAnchor.constraint(equalTo: likeButton.topAnchor),
            bottomBackgroundView.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.topAnchor.constraint(equalTo: likeButton.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor),
            shareButton.heightAnchor.constraint(equalTo: likeButton.heightAnchor),
            
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            shadowView.topAnchor.constraint(equalTo: bottomBackgroundView.bottomAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension EventTableCell: ConfigurableCell {
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data

        dataLabel.text = data.title
        dateLabel.text = data.date
        
        contentView.backgroundColor = data.backgroundColor
        dateLabel.backgroundColor = data.backgroundColor
        dataLabel.textColor = data.textColor
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        
        let imageID = data.imageID
        let uid = data.uid
        
        if !imageID.isEmpty {
            ImagesManager.shared.getImage(withName: imageID, eventUID: uid) { [weak self] (image) in
                guard let self = self else { return }
                if let image = image {
                    self.dataImageView.image = image
                } else {
                    self.dataImageView.image = self.noImage
                }
            }
        }
        
        FirebaseManager.shared.databaseManager.getEventLikeInfo(eventID: uid) { (count, userLikes) in
            DispatchQueue.main.async {
                self.likeButton.setTitle("\(count)", for: .normal)
                self.likeButton.setTitle("\(count)", for: .selected)
                self.likeButton.isSelected = userLikes
                self.likeButton.tintColor = self.getLikeButtonTintColor(isSelected: userLikes)
                self.data?.likesCount = count                
            }
        }
        
    }
}

extension EventTableCell {
    
    @objc
    private func handleLikeAction() {
        likeButton.isSelected.toggle()
        likeButton.tintColor = getLikeButtonTintColor(isSelected: likeButton.isSelected)
        data?.likeAction(likeButton.isSelected)
        self.data?.likesCount += (likeButton.isSelected ? 1 : -1)
        likeButton.setTitle("\(self.data?.likesCount ?? 0)", for: .normal)
        likeButton.setTitle("\(self.data?.likesCount ?? 0)", for: .selected)
    }
    
    @objc
    private func handleShareAction() {
        self.shareButton.isSelected.toggle()
        data?.shareAction()
    }
    
    private func getLikeButtonTintColor(isSelected: Bool) -> UIColor {
        return isSelected ? Asset.accent0.color : Asset.other0.color
    }
    
}
