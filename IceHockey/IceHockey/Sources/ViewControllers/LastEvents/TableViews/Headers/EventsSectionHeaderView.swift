//
//  EventsSectionHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//

import UIKit

class EventsSectionHeaderView: UITableViewHeaderFooterView, ConfigurableCell {
    
    // MARK: - Properties
    typealias DataType = String
    
    var isInterfaceConfigured = false
    let imageHeight: CGFloat = 24
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel (header table view)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.text = L10n.News.tableViewNewsSectionTitle
        return view
    }()
        
    private lazy var dataImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView (header table view)"
        view.image = Asset.home.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    func configureUI() {
        if isInterfaceConfigured { return }
        tintColor = Asset.other1.color
        contentView.addSubview(dataImageView)
        contentView.addSubview(dataLabel)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalToConstant: 40),
            dataImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            dataLabel.leadingAnchor.constraint(equalTo: dataImageView.trailingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: imageHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(with data: String) {
        // do nothing
    }
}
