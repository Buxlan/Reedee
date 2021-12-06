//
//  EventDetailHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/12/21.
//

import UIKit

class EventDetailHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = EventDetailHeaderCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()
        
    // MARK: - Lifecircle
    
    override func prepareForReuse() {
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(dataLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let widthConstraint = dataLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -32)
        let heightConstraint = dataLabel.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, constant: -16)
        widthConstraint.priority = .defaultLow
        heightConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            dataLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            widthConstraint,
            heightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCollectionContent extension
extension EventDetailHeaderView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        dataLabel.text = data.title
        dataLabel.textColor = data.textColor
        contentView.backgroundColor = data.backgroundColor
        dataLabel.backgroundColor = data.backgroundColor
    }
    
}
