//
//  EditEventBoldTextCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class EditEventBoldTextCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = String?
    typealias HandlerType = EditEventHandler
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var eventTextField: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont14
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
        contentView.addSubview(eventTextField)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            eventTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            eventTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventTextField.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventBoldTextCell: ConfigurableActionCell {
    
    func configure(with data: DataType = nil, handler: HandlerType) {
        configureUI()
        eventTextField.text = data
        eventTextField.delegate = handler
    }
    
}
