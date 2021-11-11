//
//  SquadHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/2/21.
//

import UIKit

class SquadHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = SquadHeaderCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.textAlignment = .left
        view.font = .boldFont16
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
        let constraints: [NSLayoutConstraint] = [
            dataLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCollectionContent extension
extension SquadHeaderView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        dataLabel.text = data.title
        dataLabel.textColor = Asset.other3.color
        contentView.backgroundColor = Asset.accent0.color
        dataLabel.backgroundColor = Asset.accent0.color
    }
    
}
