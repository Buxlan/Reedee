//
//  TeamDetailInfoTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/31/21.
//

import UIKit

class TeamDetailInfoTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var phoneTextView: UITextView = {
//        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let view = UITextView()
        view.textAlignment = .left
        view.font = .boldFont16
        view.isEditable = false
        view.dataDetectorTypes = .phoneNumber
//        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
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
        contentView.addSubview(phoneTextView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            phoneTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            phoneTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            phoneTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            phoneTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension TeamDetailInfoTableCell: ConfigurableCell {
        
    typealias DataType = SportTeam
    func configure(with data: DataType) {
        configureUI()
        phoneTextView.text = L10n.Team.phoneTitle + data.phone
    }
    
}
