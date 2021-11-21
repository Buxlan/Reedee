//
//  EventDetailUsefulButtonsTableViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import UIKit

class EventDetailUsefulButtonsView: UIView {
    
    // MARK: - Properties
    
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var likeButton: LikeButton = {
        let view = LikeButton()
        view.accessibilityIdentifier = "likeButton"
        view.setTitle("0", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return view
    }()
    
    private lazy var shareButton: ShareButton = {
        let view = ShareButton()
        view.accessibilityIdentifier = "shareButton"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return view
    }()
    
    private lazy var viewsCountImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "viewsCountImageView"
        view.image = Asset.eye.image.resizeImage(to: 16,
                                                 aspectRatio: .current,
                                                 with: Asset.accent0.color).withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var viewsCountLabel: ConfigurableLabel = {
        let view = ConfigurableLabel()
        view.accessibilityIdentifier = "viewsCountLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions    
    
    func configureUI() {
        if isInterfaceConfigured { return }
        self.backgroundColor = Asset.other2.color
        tintColor = Asset.other1.color
//        contentView.addSubview(coloredView)
        self.addSubview(viewsCountImageView)
        self.addSubview(viewsCountLabel)
        self.addSubview(likeButton)
        self.addSubview(shareButton)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [            
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            shareButton.topAnchor.constraint(equalTo: likeButton.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor),
            shareButton.heightAnchor.constraint(equalTo: likeButton.heightAnchor),
            
            viewsCountImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.centerXAnchor),
            viewsCountImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewsCountImageView.widthAnchor.constraint(equalToConstant: 28),
            viewsCountImageView.heightAnchor.constraint(equalToConstant: 28),
            
            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsCountImageView.trailingAnchor, constant: 4),
            viewsCountLabel.centerYAnchor.constraint(equalTo: viewsCountImageView.centerYAnchor),
            viewsCountLabel.heightAnchor.constraint(equalTo: viewsCountImageView.heightAnchor),
            viewsCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EventDetailUsefulButtonsView: ConfigurableCollectionContent {
    
    typealias DataType = EventDetailUsefulButtonsCellModel
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        viewsCountLabel.textColor = data.tintColor
        viewsCountLabel.backgroundColor = data.backgroundColor
        
        self.backgroundColor = data.backgroundColor
        self.backgroundColor = data.backgroundColor
        
        shareButton.setTitleColor(data.tintColor, for: .normal)
        shareButton.tintColor = data.tintColor
        shareButton.backgroundColor = data.backgroundColor
        
        viewsCountImageView.tintColor = data.tintColor
        viewsCountImageView.backgroundColor = data.backgroundColor
        
        likeButton.setTitleColor(data.tintColor, for: .normal)
        likeButton.setTitleColor(data.selectedViewTintColor, for: .selected)
        likeButton.backgroundColor = data.backgroundColor
        
        self.likeButton.isSelected = data.likesInfo.isLiked
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: data.likesInfo.count)
        self.likeButton.configure(with: model)
    }
    
}

// MARK: - Control Handlers
extension EventDetailUsefulButtonsView {
        
    @objc private func handleLike() {
        guard let data = self.data else {
            return
        }
        likeButton.isSelected.toggle()
        let state = likeButton.isSelected
        let count = data.likesInfo.count + (state ? 1 : -1)
        
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: count)
        likeButton.configure(with: model)
        
        self.data?.likesInfo.isLiked = state
        self.data?.likesInfo.count = count
        
        self.data?.likeAction(state)
    }
    
    @objc private func handleShare() {
        data?.shareAction()
    }
    
}
