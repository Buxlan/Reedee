//
//  EditEventSaveCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class EditEventSaveCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = String?
    typealias HandlerType = EditEventHandler
    private var handler: HandlerType?
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "saveButton"
        view.backgroundColor = Asset.other3.color
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        view.setTitle(L10n.Events.save, for: .normal)
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
        contentView.addSubview(saveButton)
        configureConstraints()
        isInterfaceConfigured = true
        saveButton.addTarget(self, action: #selector(buttonHandle(_:)), for: .touchUpInside)
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            saveButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventSaveCell: ConfigurableActionCell {
    
    func configure(with data: DataType = nil, handler: HandlerType) {
        configureUI()
        self.handler = handler
    }
    
    @objc
    private func buttonHandle(_ sender: UIButton) {
        handler?.save()
    }
    
}

