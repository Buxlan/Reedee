//
//  TeamInfoTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/31/21.
//

import UIKit

class TeamInfoTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 0
        
        view.addArrangedSubview(phoneTextView)
        view.addArrangedSubview(emailTextView)
        view.addArrangedSubview(addressTextView)
        
        return view
    }()
    
    private lazy var addressTextView: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.font = .boldFont17
        view.isEditable = true
        view.dataDetectorTypes = .address
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.isScrollEnabled = false
        view.backgroundColor = self.backgroundColor
        view.textColor = Asset.textColor.color
        return view
    }()
    
    private lazy var phoneTextView: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.font = .boldFont17
        view.isEditable = false
        view.dataDetectorTypes = .phoneNumber
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.isScrollEnabled = false
        view.backgroundColor = self.backgroundColor
        view.textColor = Asset.textColor.color
        return view
    }()
    
    private lazy var emailTextView: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.font = .boldFont17
        view.isEditable = false
        view.dataDetectorTypes = .link
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.isScrollEnabled = false
        view.backgroundColor = self.backgroundColor
        view.textColor = Asset.textColor.color
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
        contentView.addSubview(stackView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension TeamInfoTableCell: ConfigurableCell {
        
    typealias DataType = Club
    func configure(with data: DataType) {
        configureUI()
        phoneTextView.text = L10n.Team.phoneTitle + data.phone
        addressTextView.text = L10n.Team.addressTitle + data.address
        emailTextView.text = L10n.Team.emailTitle + data.email
    }
    
}
