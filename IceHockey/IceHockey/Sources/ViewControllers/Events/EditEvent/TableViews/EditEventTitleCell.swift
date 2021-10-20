//
//  EditEventTitleCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier: String = String(describing: self)
    var isInterfaceConfigured: Bool = false
        
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.text = L10n.Events.addEventTitle
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
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
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTitleCell: ConfigurableCell {
    typealias DataType = String?
    func configure(with data: DataType = nil) {
        configureUI()
    }
}
