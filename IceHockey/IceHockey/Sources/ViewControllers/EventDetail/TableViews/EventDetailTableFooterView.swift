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
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "imageView"
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
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 6
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
        view.textColor = Asset.other3.color
        return view
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        view.textColor = Asset.other3.color
        return view
    }()

    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        self.backgroundColor = Asset.accent0.color
        tintColor = Asset.other1.color
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(copyrightLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.heightAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
//            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: copyrightLabel.topAnchor, constant: -8),
//            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
            
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
        titleLabel.text = data.displayName
        copyrightLabel.text = data.copyright
        imageView.image = Asset.logoRedBGColor.image
    }
}
