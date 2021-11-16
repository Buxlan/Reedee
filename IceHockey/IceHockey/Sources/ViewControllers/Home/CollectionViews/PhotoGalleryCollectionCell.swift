//
//  PhotoGalleryCollectionCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/20/21.
//

import UIKit

class PhotoGalleryCollectionCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - Properties
    typealias DataType = SportNewsDatabaseFlowImpl
    
    internal var isInterfaceConfigured: Bool = false
    let imageAspectRate: CGFloat = 1.77
    let imageHeight: CGFloat = 160
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = CorneredView(corners: [.topLeft, .topRight], radius: cornerRadius)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.roundCorners(corners: [.allCorners], radius: 40)
//        view.clipsToBounds = true
        return view
    }()
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = UIView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel (table cell)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.numberOfLines = 2
        view.textAlignment = .left
        return view
    }()
        
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
    
    private lazy var viewsCountImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "viewsCountImageView"
        view.image = Asset.eye.image.resizeImage(to: 16,
                                                 aspectRatio: .current,
                                                 with: Asset.accent0.color).withRenderingMode(.alwaysTemplate)
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewsCountLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "viewsCountLabel (collection cell)"
//        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var actionEventButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "readEventButton (collection cell)"
//        view.setMargins(margin: 32.0)
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
//        let backView = UIView()
//        backView.backgroundColor = Asset.other1.color
//        backgroundView = backView
//        contentView.addSubview(roundedView)
        
        contentView.addSubview(shadowView)
        contentView.addSubview(dataImageView)
        contentView.addSubview(dataLabel)
        contentView.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(viewsCountImageView)
        bottomBackgroundView.addSubview(viewsCountLabel)
        contentView.addSubview(actionEventButton)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -8),
//            dataLabel.heightAnchor.constraint(equalToConstant: 44),
            dataLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            dataImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            dataImageView.heightAnchor.constraint(equalTo: dataImageView.widthAnchor, multiplier: 0.7),
            dataImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
            viewsCountImageView.leadingAnchor.constraint(equalTo: bottomBackgroundView.leadingAnchor, constant: 8),
            viewsCountImageView.centerYAnchor.constraint(equalTo: bottomBackgroundView.centerYAnchor),
            viewsCountImageView.heightAnchor.constraint(equalToConstant: 16),
            viewsCountImageView.widthAnchor.constraint(equalToConstant: 28),
//            viewsCountImageView.bottomAnchor.constraint(equalTo: viewsCountImageView.topAnchor),

            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsCountImageView.trailingAnchor, constant: 4),
            viewsCountLabel.centerYAnchor.constraint(equalTo: viewsCountImageView.centerYAnchor),
            viewsCountLabel.heightAnchor.constraint(equalTo: viewsCountImageView.heightAnchor),
            viewsCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: bottomBackgroundView.trailingAnchor),

            bottomBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bottomBackgroundView.topAnchor.constraint(equalTo: dataImageView.bottomAnchor),
            bottomBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            bottomBackgroundView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.topAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: bottomBackgroundView.heightAnchor)
            
//            actionEventButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            actionEventButton.centerYAnchor.constraint(equalTo: viewsCountImageView.centerYAnchor),
//            actionEventButton.heightAnchor.constraint(equalToConstant: 32),
//            actionEventButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 130),
//            actionEventButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Helper functions
    func configure(with data: DataType) {
        configureInterface()
//        dataImageView.image = data.image
        dataLabel.text = data.title
        actionEventButton.setTitle(L10n.Events.defaultActionTitle, for: .normal)
//        setNeedsLayout()
    }
}
