//
//  EventDetailUsefulButtonsTableViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import UIKit

class EventDetailUsefulButtonsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "likeButton"
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.backgroundColor = Asset.other2.color
        let image = Asset.favorite.image.withRenderingMode(.alwaysTemplate)
        let selectedImage = Asset.fillFavorite.image.withRenderingMode(.alwaysTemplate)
        view.tintColor = Asset.other0.color
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "shareButton"
        view.backgroundColor = Asset.other2.color
        view.tintColor = Asset.other0.color
        view.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        let image = Asset.share.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        
        return view
    }()
    
    private lazy var viewsCountImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "viewsCountImageView"
        view.image = Asset.eye.image.resizeImage(to: 16,
                                                 aspectRatio: .current,
                                                 with: Asset.accent0.color).withRenderingMode(.alwaysTemplate)
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other2.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "viewsCountLabel (collection cell)"
        view.backgroundColor = Asset.other2.color
        view.textColor = Asset.other0.color
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
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions    
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other2.color
        tintColor = Asset.other1.color
//        contentView.addSubview(coloredView)
        contentView.addSubview(viewsCountImageView)
        contentView.addSubview(viewsCountLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [            
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            likeButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 32),
            shareButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            shareButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            viewsCountImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor),
            viewsCountImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewsCountImageView.widthAnchor.constraint(equalToConstant: 28),
            viewsCountImageView.heightAnchor.constraint(equalToConstant: 28),
            
            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsCountImageView.trailingAnchor, constant: 4),
            viewsCountLabel.centerYAnchor.constraint(equalTo: viewsCountImageView.centerYAnchor),
            viewsCountLabel.heightAnchor.constraint(equalTo: viewsCountImageView.heightAnchor),
            viewsCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - Control Handlers
extension EventDetailUsefulButtonsTableViewCell {
    
    @objc
    private func shareButtonTapped() {
        self.shareButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
}

// MARK: - ConfigurableCell extension
extension EventDetailUsefulButtonsTableViewCell: ConfigurableCell {
        
    typealias DataType = SportEvent
    func configure(with data: DataType) {
        configureUI()
        viewsCountLabel.text = "123"
    }
    
}
