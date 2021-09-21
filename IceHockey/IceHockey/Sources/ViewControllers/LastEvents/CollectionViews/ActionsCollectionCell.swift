//
//  PinnedCollectionCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

class ActionsCollectionCell: UICollectionViewCell, ConfigurableCell {
    // MARK: - Properties
    typealias DataType = QuickAction
    
    internal var isInterfaceConfigured: Bool = false
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = CorneredView(corners: [.topLeft, .topRight], radius: cornerRadius)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.roundCorners(corners: [.allCorners], radius: 40)
//        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel (table cell)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 2
        view.textAlignment = .left
        view.font = .regularFont14
        return view
    }()
        
    private var imageSize: CGSize {
        .init(width: 32, height: 32)
    }
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    func configureInterface() {
        if isInterfaceConfigured { return }
        tintColor = UIColor.black
        backgroundColor = Asset.other3.color
        contentView.addSubview(dataImageView)
        contentView.addSubview(dataLabel)
        configureConstraints()
        isInterfaceConfigured = true
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dataImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            dataImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            
            dataLabel.leadingAnchor.constraint(equalTo: dataImageView.trailingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            dataLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            dataLabel.heightAnchor.constraint(equalToConstant: 44),
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//            viewsCountImageView.leadingAnchor.constraint(equalTo: bottomBackgroundView.leadingAnchor, constant: 8),
//            viewsCountImageView.centerYAnchor.constraint(equalTo: bottomBackgroundView.centerYAnchor),
//            viewsCountImageView.heightAnchor.constraint(equalToConstant: 16),
//            viewsCountImageView.widthAnchor.constraint(equalToConstant: 28),
////            viewsCountImageView.bottomAnchor.constraint(equalTo: viewsCountImageView.topAnchor),
//
//            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsCountImageView.trailingAnchor, constant: 4),
//            viewsCountLabel.centerYAnchor.constraint(equalTo: viewsCountImageView.centerYAnchor),
//            viewsCountLabel.heightAnchor.constraint(equalTo: viewsCountImageView.heightAnchor),
//            viewsCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: bottomBackgroundView.trailingAnchor),
//
//            bottomBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            bottomBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            bottomBackgroundView.topAnchor.constraint(equalTo: dataImageView.bottomAnchor),
//            bottomBackgroundView.heightAnchor.constraint(equalToConstant: 40),
//            bottomBackgroundView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
//
//            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            shadowView.topAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
//            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            shadowView.heightAnchor.constraint(equalTo: bottomBackgroundView.heightAnchor),
            
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
        dataImageView.image = data.image
        dataLabel.text = data.title
    }
    
}
