//
//  EditEventSaveCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class EditEventSaveCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = SaveCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "saveButton"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        return view
    }()

    // MARK: - Lifecircle    
    
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
        let saveHeightConstraint = saveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        saveHeightConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            saveButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            saveButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            saveHeightConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventSaveCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        saveButton.setTitleColor(data.textColor, for: .normal)
        saveButton.setTitle(data.title, for: .normal)
        saveButton.backgroundColor = data.backgroundColor
    }
    
    @objc
    private func buttonHandle(_ sender: UIButton) {
//        handler?.save()
    }
    
}
