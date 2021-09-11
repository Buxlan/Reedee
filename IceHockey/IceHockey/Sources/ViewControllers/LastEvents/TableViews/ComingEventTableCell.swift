//
//  ComingEventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

class ComingEventTableCell: UITableViewCell, ConfigurableCell {
    // MARK: - Properties
    typealias DataType = SportEvent
    
    var isInterfaceConfigured = false
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: DataType) {
        self.textLabel?.text = data.title
        self.detailTextLabel?.text = data.text
    }
}
