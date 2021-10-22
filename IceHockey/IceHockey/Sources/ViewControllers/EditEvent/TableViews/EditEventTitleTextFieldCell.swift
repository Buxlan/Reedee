//
//  EditEventTitleTextFieldCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTitleTextFieldCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = String?
    typealias HandlerType = EditEventHandler
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = L10n.Events.editEventTitlePlaceholder
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
        view.autocorrectionType = .no
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
            titleTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTitleTextFieldCell: ConfigurableActionCell {
    
    func configure(with data: DataType, handler: HandlerType) {
        configureUI()
        titleTextField.delegate = handler
        titleTextField.text = data
    }
    
}
