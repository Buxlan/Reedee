//
//  EventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

class NewsTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = NewsTableCellModel
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
        view.font = Fonts.Regular.subhead
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
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
        view.numberOfLines = 5
        view.textAlignment = .left
        view.font = Fonts.Regular.body
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return view
    }()
    
    private lazy var dateLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "dateLabel (table cell)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.textAlignment = .left
        view.font = Fonts.Regular.body
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel (table cell)"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.font = Fonts.Bold.subhead
        return view
    }()
    
    private lazy var likeButton: LikeButton = {
        let view = LikeButton()
        view.accessibilityIdentifier = "likeButton"
        view.setTitle("0", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleLikeAction), for: .touchUpInside)
        return view
    }()
    
    private lazy var shareButton: ShareButton = {
        let view = ShareButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Asset.other0.color
        view.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
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
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
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
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: userImageHeight),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.heightAnchor.constraint(equalToConstant: userImageHeight),
            
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: typeLabel.leadingAnchor, constant: -8),
            usernameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeLabel.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 4),
            typeLabel.heightAnchor.constraint(equalTo: userImageView.heightAnchor, constant: -8),
            typeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataImageView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            dataImageView.heightAnchor.constraint(equalTo: dataImageView.widthAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataLabel.topAnchor.constraint(equalTo: dataImageView.bottomAnchor, constant: 8),
//            dataLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
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
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
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

extension NewsTableCell: ConfigurableCollectionContent {
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data

        dataLabel.text = data.title
        dateLabel.text = data.date
        
        contentView.backgroundColor = data.backgroundColor
        dateLabel.backgroundColor = data.backgroundColor
        dataLabel.backgroundColor = data.backgroundColor
        dataLabel.textColor = data.textColor
        dateLabel.textColor = Asset.other0.color
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        usernameLabel.backgroundColor = data.backgroundColor
        userImageView.backgroundColor = data.backgroundColor
        usernameLabel.textColor = data.textColor
        
        self.usernameLabel.text = data.author
        self.userImageView.image = data.authorImage == nil ? noImage : data.authorImage
        
        dataImageView.image = data.image
        
        self.likeButton.isSelected = data.likesInfo.isLiked
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: data.likesInfo.count)
        self.likeButton.configure(with: model)
        
    }
}

extension NewsTableCell {
    
    @objc
    private func handleLikeAction() {
        guard let data = self.data else { return }
        likeButton.isSelected.toggle()
        data.likeAction(likeButton.isSelected)
        let count = data.likesInfo.count + (likeButton.isSelected ? 1 : -1)
        self.data?.likesInfo.count = count
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: count)
        likeButton.configure(with: model)
    }
    
    @objc
    private func handleShareAction() {
        data?.shareAction()
    }
}
