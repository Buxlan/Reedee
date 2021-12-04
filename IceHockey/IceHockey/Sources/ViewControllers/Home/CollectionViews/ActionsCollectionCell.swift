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
        view.textColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 2
        view.textAlignment = .left
        view.font = Fonts.Regular.body
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
            dataLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Helper functions
    func configure(with data: DataType) {
        configureInterface()
        dataImageView.image = data.image
        dataLabel.text = data.description
    }
    
}
