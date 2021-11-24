//
//  OurSquadsTitleTextViewCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import UIKit

class OurSquadsTitleTextViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var titleTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = false
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.font = .boldFont17
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
        contentView.addSubview(titleTextView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            titleTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            titleTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - ConfigurableCell extension
extension OurSquadsTitleTextViewCell: ConfigurableCell {
        
    typealias DataType = Club
    func configure(with data: DataType) {
        configureUI()
        titleTextView.text = data.webSite
    }
    
}
