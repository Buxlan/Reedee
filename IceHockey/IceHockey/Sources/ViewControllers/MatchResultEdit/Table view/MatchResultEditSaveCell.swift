//
//  MatchResultEditSaveCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import UIKit

class MatchResultEditSaveCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = SaveCellModel
    var data: DataType?
    
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
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
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
        saveButton.addTarget(self, action: #selector(handleSave(_:)), for: .touchUpInside)
    }
    
    internal func configureConstraints() {
        let saveHeightConstraint = saveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        saveHeightConstraint.priority = .defaultHigh
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

extension MatchResultEditSaveCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        saveButton.backgroundColor = Asset.accent0.color
        saveButton.setTitleColor(Asset.other3.color, for: .normal)
    }
    
}

extension MatchResultEditSaveCell {
    
    @objc private func handleSave(_ sender: UIButton) {
        data?.action()
    }
}
