//
//  EventsSectionHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//

import UIKit

class EventsSectionHeaderView: UITableViewCell, ConfigurableCell {
    
    // MARK: - Properties
    typealias DataType = NewsTableViewCellHeaderConfiguration
    
    var isInterfaceConfigured = false
    let defaultSize = DataType.defaultSize
    let defaultImageSize = DataType.defaultImageSize
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel (header table view)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other2.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var leftImageHeightConstraint: NSLayoutConstraint = {
        let constraint = leftImageView.heightAnchor.constraint(equalToConstant: defaultImageSize.height)
        constraint.isActive = true
        return constraint
    }()
    private lazy var leftImageWidthConstraint: NSLayoutConstraint = {
        let constraint = leftImageView.widthAnchor.constraint(equalToConstant: defaultImageSize.width)
        constraint.isActive = true
        return constraint
    }()
    private lazy var rightImageHeightConstraint: NSLayoutConstraint = {
        let constraint = rightImageView.heightAnchor.constraint(equalToConstant: defaultImageSize.height)
        constraint.isActive = true
        return constraint
    }()
    private lazy var rightImageWidthConstraint: NSLayoutConstraint = {
        let constraint = rightImageView.widthAnchor.constraint(equalToConstant: defaultImageSize.width)
        constraint.isActive = true
        return constraint
    }()
    
    private lazy var contentViewHeightConstraint: NSLayoutConstraint = {
        let constraint = contentView.heightAnchor.constraint(equalToConstant: defaultSize.height)
        constraint.isActive = true
        return constraint
    }()
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "leftImageView (header table view)"
        view.backgroundColor = Asset.other2.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Asset.other0.color
        return view
    }()
    
    private lazy var rightImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "rightImageView (header table view)"
        view.backgroundColor = Asset.other2.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Asset.other0.color
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other2.color
        contentView.addSubview(leftImageView)
        contentView.addSubview(rightImageView)
        contentView.addSubview(dataLabel)
        textLabel?.isHidden = true
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
                
        var constraints: [NSLayoutConstraint] = [
            contentViewHeightConstraint,
            
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            leftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 12),
            dataLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -12),
            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ]
        constraints.append(leftImageWidthConstraint)
        constraints.append(leftImageHeightConstraint)
        constraints.append(rightImageWidthConstraint)
        constraints.append(rightImageHeightConstraint)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with data: DataType) {
        leftImageView.image = data.leftImage
        rightImageView.image = data.rightImage
        dataLabel.text = data.title
        
        if let image = leftImageView.image {
            leftImageWidthConstraint.constant = image.size.width
            leftImageHeightConstraint.constant = image.size.width
            leftImageWidthConstraint.isActive = true
            leftImageHeightConstraint.isActive = true
        }
        if let image = rightImageView.image {
            rightImageWidthConstraint.constant = image.size.width
            rightImageHeightConstraint.constant = image.size.width
            rightImageWidthConstraint.isActive = true
            rightImageHeightConstraint.isActive = true
        }
        contentViewHeightConstraint.constant = data.size.height
    }
}
