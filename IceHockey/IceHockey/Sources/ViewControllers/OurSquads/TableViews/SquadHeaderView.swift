//
//  SquadHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/2/21.
//

import UIKit

class SquadHeaderView: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 0
        view.backgroundColor = self.backgroundColor
        view.addArrangedSubview(infoTextView)
        
        return view
    }()
    
    private lazy var infoTextView: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.font = .boldFont16
        view.isEditable = true
        view.dataDetectorTypes = .all
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
extension SquadHeaderView: ConfigurableCell {
    
    func configure(with data: SportTeam?) {
        guard let data = data else { return }
        configureUI()
        infoTextView.text = data.ourSquadsTitle
    }
    
}
