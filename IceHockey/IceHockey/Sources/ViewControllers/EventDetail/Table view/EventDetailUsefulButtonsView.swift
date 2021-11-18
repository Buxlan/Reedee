//
//  EventDetailUsefulButtonsTableViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/19/21.
//

import UIKit

class EventDetailUsefulButtonsView: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = "") {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
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
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.topAnchor.constraint(equalTo: likeButton.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor),
            shareButton.heightAnchor.constraint(equalTo: likeButton.heightAnchor),
            
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

extension EventDetailUsefulButtonsView: ConfigurableCollectionContent {
    
    typealias DataType = EventDetailUsefulButtonsCellModel
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        viewsCountLabel.textColor = data.tintColor
        viewsCountLabel.backgroundColor = data.backgroundColor
        
        contentView.backgroundColor = data.backgroundColor
        
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
        
//        FirebaseManager.shared.databaseManager
//            .getEventLikeInfo(eventID: data.eventID) { (count, userLikes) in
//            DispatchQueue.main.async {
//                self.likeButton.isSelected = userLikes
//                self.data?.likesCount = count
//                let model = LikeButtonModelImpl(textColor: data.textColor,
//                                                count: count)
//                self.likeButton.configure(with: model)
//            }
//        }
//
//        FirebaseManager.shared.databaseManager
//            .getEventViewsInfo(eventID: data.eventID) { (count) in
//            DispatchQueue.main.async {
//                self.data?.viewsCount = count
//                let model = LabelModelImpl(text: "\(count)",
//                                           font: data.font,
//                                           textColor: data.tintColor,
//                                           backgroundColor: data.backgroundColor)
//                self.viewsCountLabel.configure(with: model)
//            }
//        }
        
    }
    
}

// MARK: - Control Handlers
extension EventDetailUsefulButtonsView {
        
    @objc private func handleLike() {
        guard let data = self.data else { return }
        likeButton.isSelected.toggle()
        data.likeAction(likeButton.isSelected)
        let count = data.likesInfo.count + (likeButton.isSelected ? 1 : -1)
        self.data?.likesInfo.count = count
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: count)
        likeButton.configure(with: model)
    }
    
    @objc private func handleShare() {
        self.shareButton.isSelected.toggle()
        data?.shareAction()
    }
    
}
