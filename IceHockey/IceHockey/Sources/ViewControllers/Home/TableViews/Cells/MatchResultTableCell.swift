//
//  MatchResultTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import UIKit
import Firebase

class MatchResultTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = MatchResultTableCellModel
    
    var isInterfaceConfigured = false
    var heightAspectRate: CGFloat = 0.7
    let avatarHeight: CGFloat = 60.0
    
    private lazy var placeholderImage: UIImage = {
        Asset.camera.image.resizeImage(to: avatarHeight, aspectRatio: .current, with: .clear)
    }()
    private lazy var noImage: UIImage = {
        Asset.noImage256.image.resizeImage(to: avatarHeight, aspectRatio: .current, with: .clear)
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel"
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
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .regularFont12
        return view
    }()
    
    private lazy var stadiumLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "stadiumLabel"
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = .regularFont12
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
        view.backgroundColor = Asset.other3.color
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .regularFont12
        return view
    }()
    
    private lazy var logoHomeTeamImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "logoHomeTeamImageView"
        view.image = Asset.camera.image.resizeImage(to: avatarHeight, aspectRatio: .current, with: .clear)
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoAwayTeamImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "logoHomeTeamImageView"
        view.image = Asset.camera.image.resizeImage(to: avatarHeight, aspectRatio: .current, with: .clear)
        view.backgroundColor = Asset.other3.color
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "scoreLabel"
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = .regularFont50
        view.textColor = Asset.textColor.color
        return view
    }()
    
    private lazy var homeTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamLabel"
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .left
        view.font = .regularFont16
        view.textColor = Asset.textColor.color
        return view
    }()
    
    private lazy var awayTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamLabel"
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .left
        view.font = .regularFont16
        view.textColor = Asset.textColor.color
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel"
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 5
        view.textAlignment = .left
        view.textColor = Asset.textColor.color
        view.font = .regularFont14
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "likeButton"
        view.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        view.backgroundColor = contentView.backgroundColor
        let image = Asset.favorite.image.withRenderingMode(.alwaysTemplate)
            .resizeImage(to: 32, aspectRatio: .current, with: Asset.other0.color)
        let selectedImage = Asset.fillFavorite.image.withRenderingMode(.alwaysTemplate)
            .resizeImage(to: 32, aspectRatio: .current, with: Asset.other0.color)
        view.tintColor = Asset.other0.color
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.setTitleColor(Asset.textColor.color, for: .selected)
        view.imageView?.tintColor = Asset.other0.color
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 8)
        view.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
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
        logoHomeTeamImageView.image = nil
        logoAwayTeamImageView.image = nil
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(dateLabel)
        contentView.addSubview(stadiumLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(logoHomeTeamImageView)
        contentView.addSubview(logoAwayTeamImageView)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(typeLabel)
        
        logoHomeTeamImageView.isHidden = true
        logoAwayTeamImageView.isHidden = true
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: logoHomeTeamImageView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: logoAwayTeamImageView.leadingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: stadiumLabel.topAnchor, constant: -8),
            
            logoHomeTeamImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            logoHomeTeamImageView.heightAnchor.constraint(equalToConstant: avatarHeight),
            logoHomeTeamImageView.widthAnchor.constraint(equalToConstant: avatarHeight),
            
            logoAwayTeamImageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            logoAwayTeamImageView.heightAnchor.constraint(equalToConstant: avatarHeight),
            logoAwayTeamImageView.widthAnchor.constraint(equalToConstant: avatarHeight),
            
            stadiumLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stadiumLabel.leadingAnchor.constraint(equalTo: logoHomeTeamImageView.trailingAnchor, constant: 16),
            stadiumLabel.trailingAnchor.constraint(equalTo: logoAwayTeamImageView.leadingAnchor, constant: -16),
            stadiumLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -8),
            
            statusLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: logoHomeTeamImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: logoAwayTeamImageView.leadingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -8),
            
            scoreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: logoHomeTeamImageView.trailingAnchor, constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: logoAwayTeamImageView.leadingAnchor, constant: -16),
            scoreLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16),
            
            homeTeamLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -16),
            homeTeamLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            homeTeamLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            
            awayTeamLabel.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 16),
            awayTeamLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            awayTeamLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 24),
            
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likeButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            likeButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16),
//            likeButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MatchResultTableCell: ConfigurableCell {
    
    func configure(with data: DataType) {
        configureUI()
        
        dateLabel.text = data.date
        statusLabel.text = data.status
        stadiumLabel.text = data.stadium
        
        scoreLabel.text = data.score
        homeTeamLabel.text = data.homeTeam
        awayTeamLabel.text = data.awayTeam
        
        typeLabel.text = data.type
        titleLabel.text = data.title
        
        FirebaseManager.shared.databaseManager.getEventLikeCount(eventID: data.eventUid) { (count) in
            DispatchQueue.main.async {
                self.likeButton.setTitle("\(count)", for: .normal)
                self.likeButton.setTitle("\(count)", for: .selected)
            }
        }
        
//        guard let userID = Auth.auth().currentUser?.uid else {
//            return
//        }
        let userID = "userID1"
        FirebaseManager.shared.databaseManager.getEventIsLiked(eventID: data.eventUid, userID: userID) { (isLiked) in
            DispatchQueue.main.async {
                self.likeButton.isSelected = isLiked
            }
        }
        
    }
    
}

extension MatchResultTableCell {
    
    @objc
    private func likeButtonTapped() {
        self.likeButton.isSelected.toggle()
        Log(text: "shareButtonTapped", object: nil)
    }
    
}
