//
//  EventDetailBoldTextTableViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

class EventDetailBoldViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var boldTextLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.font = .boldFont16
        view.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(boldTextLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            boldTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            boldTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            boldTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            boldTextLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension EventDetailBoldViewCell: ConfigurableCell {
        
    typealias DataType = SportEvent
    func configure(with data: DataType) {
        configureUI()
        boldTextLabel.text = data.boldText
    }
    
}

