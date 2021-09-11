//
//  ComingEventsSectionHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//

import UIKit

class ComingEventsSectionHeaderView: UITableViewHeaderFooterView, ConfigurableCell {
    
    // MARK: - Properties
    typealias DataType = String
    
    var isInterfaceConfigured = false
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    func configureUI() {
        if isInterfaceConfigured { return }
        tintColor = Asset.other1.color
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with data: String) {
        // do nothing
    }
}
