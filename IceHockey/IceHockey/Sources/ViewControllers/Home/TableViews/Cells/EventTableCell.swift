//
//  EventTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit
import FirebaseStorageUI

class EventTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = NewsTableCellModel
    
    var isInterfaceConfigured = false
    var imageAspectRate: CGFloat = 1.77
    let imageHeight: CGFloat = 160
    
    private lazy var dataImageView: UIImageView = {
        let cornerRadius: CGFloat = 32.0
        let view = UIImageView()
        view.accessibilityIdentifier = "dataImageView"
//        view.image = Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private lazy var placeholderImage: UIImage = {
        Asset.camera.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
    }()
    private lazy var noImage: UIImage = {
        Asset.noImage256.image.resizeImage(to: imageHeight, aspectRatio: .current, with: .clear)
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
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel (table cell)"
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 5
        view.textAlignment = .left
        view.font = .regularFont14
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel (table cell)"
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .left
        view.font = .regularFont14
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel (table cell)"
        view.backgroundColor = Asset.accent1.color
        view.textColor = Asset.other3.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
        dataImageView.image = nil
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
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
        
//        dataImageView.isHidden = (dataImageView.image == nil)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataImageView.heightAnchor.constraint(equalTo: dataImageView.widthAnchor),
            
            dataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dataLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dataLabel.topAnchor.constraint(equalTo: dataImageView.bottomAnchor, constant: 4),
            dataLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            typeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 160),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dateLabel.topAnchor.constraint(equalTo: dataLabel.lastBaselineAnchor, constant: 0),
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

extension EventTableCell: ConfigurableCell {
    func configure(with data: DataType) {
        configureUI()

        dataLabel.text = data.title
        dateLabel.text = data.date
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        let imageID = data.imageID
        let uid = data.uid
        
        if !imageID.isEmpty {
            ImagesManager.shared.getImage(withName: imageID, eventUID: uid) { [weak self] (image) in
                guard let self = self else { return }
                if let image = image {
                    self.dataImageView.image = image
                } else {
                    self.dataImageView.image = self.noImage
                }
            }
        }
    }
}
