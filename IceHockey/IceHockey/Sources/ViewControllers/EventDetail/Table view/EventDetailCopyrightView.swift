//
//  EventDetailCopyrightTableViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

class EventDetailCopyrightView: UITableViewCell {
    
    // MARK: - Properties
        
    var isInterfaceConfigured: Bool = false
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "imageView"
        view.tintColor = Asset.other0.color
        view.backgroundColor = Asset.other2.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        let image = Asset.logo.image.resizeImage(to: 140, aspectRatio: .current)
        view.image = image
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 2
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(copyrightLabel)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 4
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        return view
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont12
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
        logoImageView.image = nil
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let logoImageViewWidthConstraint = logoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        logoImageViewWidthConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoImageViewWidthConstraint,
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            stackView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EventDetailCopyrightView: ConfigurableCollectionContent {
    
    typealias DataType = EventDetailCopyrightCellModel
    func configure(with data: DataType) {
        configureUI()
        
        titleLabel.textColor = data.textColor
        titleLabel.backgroundColor = data.backgroundColor        
        
        copyrightLabel.textColor = data.textColor
        copyrightLabel.backgroundColor = data.backgroundColor
        
        contentView.backgroundColor = data.backgroundColor
        
        guard !data.teamID.isEmpty else {
            return
        }
//        let handler: (SportTeam?) -> Void = { (team) in
//            guard let team = team else {
//                return
//            }
//            self.titleLabel.text = team.displayName
//            self.copyrightLabel.text = team.copyright
//        }
//        FirebaseObjectLoader<SportTeam>().load(uid: data.teamID, completionHandler: handler)
        
    }
    
}
