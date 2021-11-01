//
//  SimpleSectionTableHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/1/21.
//

import UIKit

class SimpleSectionTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static var reuseIdentifier: String { String(describing: Self.self) }
    
    // MARK: - Lifecircle
    
    // MARK: - Helper methods
    
    func configure(with data: SimpleTableHeaderConfiguration) {
        self.textLabel?.text = data.title
        self.textLabel?.textColor = Asset.other0.color
    }
    
}
