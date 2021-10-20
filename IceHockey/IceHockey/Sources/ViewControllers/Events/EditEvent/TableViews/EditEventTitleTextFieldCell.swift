//
//  EditEventTitleTextFieldCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTitleTextFieldCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier: String = String(describing: self)
    var isInterfaceConfigured: Bool = false
        
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = L10n.Events.editEventTitlePlaceholder
        view.textAlignment = .left
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
        contentView.addSubview(titleTextField)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTitleTextFieldCell: ConfigurableCell {
    
    typealias DataType = String?
    func configure(with data: DataType) {
        configureUI()
        titleTextField.text = data
    }
    
}
