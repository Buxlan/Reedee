//
//  EditEventTitleCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = String?
    typealias HandlerType = EditEventHandler
    var handler: HandlerType?
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var titleLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "titleLabel"
        view.numberOfLines = 2
        view.text = L10n.Events.addEventTitle
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
//        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
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
        contentView.addSubview(titleLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let labelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        labelHeightConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            labelHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTitleCell: ConfigurableCollectionContent {
    func configure(with data: DataType = nil) {
        configureUI()
    }
}
