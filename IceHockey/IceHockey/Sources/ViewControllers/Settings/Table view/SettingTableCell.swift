//
//  SettingTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import UIKit

class SettingTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    // MARK: - Lifecircle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isInterfaceConfigured = false
        accessoryType = .none
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension SettingTableCell: ConfigurableCollectionContent {
        
    typealias DataType = SettingCellModel
    func configure(with data: DataType) {
        configureUI()
        textLabel?.text = data.title
        textLabel?.textColor = data.textColor
        contentView.backgroundColor = data.backgroundColor
    }
    
}
