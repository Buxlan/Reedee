//
//  ComingEventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

class ComingEventTableCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - Properties
    typealias DataType = SportEvent
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    var cellHeight: CGFloat = 244
    let imageHeight: CGFloat = 160
    
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
        view.image = Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let cornerRadius: CGFloat = 24.0
        let view = UIView()
        view.backgroundColor = Asset.accent0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dataLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "dataLabel (table cell)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.numberOfLines = 2
        view.textAlignment = .left
        view.font = .bxBody
        return view
    }()
    
    private lazy var dateLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 8, right: 8)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "dateLabel (table cell)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .left
        view.font = .regularFont12
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel (table cell)"
        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.accent1.color
        view.textColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.font = .regularFont12
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions        
    func configure(with data: DataType) {
        configureUI()
//        dataImageView.image = data.image
        dataLabel.text = data.title
        
        var dateString: String = "12 АВГ/2021"
        if let date = data.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.locale = Locale.current
            dateString = formatter.string(from: date)
        }
        dateLabel.text = dateString
        typeLabel.text = data.type.description.uppercased()
    }
    
    func setImage(image: UIImage?) {
        dataImageView.image = image
    }
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
//        contentView.addSubview(coloredView)
        contentView.addSubview(dataImageView)
        contentView.addSubview(typeLabel)
        contentView.addSubview(dataLabel)
        contentView.addSubview(shadowView)
        contentView.addSubview(dateLabel)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let collectionViewHeight = cellHeight
        let constraints: [NSLayoutConstraint] = [
            
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataLabel.topAnchor.constraint(equalTo: dataImageView.bottomAnchor, constant: 4),
            dataLabel.heightAnchor.constraint(equalToConstant: 52),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            typeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            typeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: dataLabel.bottomAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 32),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            shadowView.topAnchor.constraint(greaterThanOrEqualTo: dateLabel.topAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 2),
            shadowView.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
