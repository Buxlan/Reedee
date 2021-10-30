//
//  EventDetailTableViewFooter.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

class EventDetailTableFooterView: UIView {
    
    // MARK: - Properties    
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "imageView"
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other2.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 6
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
        view.textColor = Asset.other0.color
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        view.textColor = Asset.other0.color
        return view
    }()

    // MARK: - Lifecircle
        
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        self.backgroundColor = Asset.accent0.color
        tintColor = Asset.other1.color
        self.addSubview(contentView)
        contentView.addSubview(dataImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(copyrightLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let titleLabelTrailingConstraint = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        titleLabelTrailingConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalTo: dataImageView.heightAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: dataImageView.trailingAnchor, constant: 8),
            titleLabelTrailingConstraint,
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -8),

            copyrightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            copyrightLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            copyrightLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            copyrightLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EventDetailTableFooterView: ConfigurableCell {
    typealias DataType = SportTeam
    func configure(with data: DataType) {
        configureUI()
        titleLabel.text = data.displayName
        copyrightLabel.text = data.copyright
        dataImageView.image = Asset.logo.image
    }
}
