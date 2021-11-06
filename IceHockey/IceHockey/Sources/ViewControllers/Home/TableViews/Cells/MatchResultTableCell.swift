//
//  MatchResultTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import UIKit

class MatchResultTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = MatchResultTableCellModel
    var data: DataType?
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 1
        view.textAlignment = .center
        view.font = .regularFont50
        return view
    }()
    
    private lazy var homeTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .left
        view.font = .regularFont16
        return view
    }()
    
    private lazy var awayTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .left
        view.font = .regularFont16
        return view
    }()
    
    private lazy var titleLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "titleLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 5
        view.textAlignment = .left
        view.font = .regularFont14
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "likeButton"
        view.addTarget(self, action: #selector(handleLikeAction), for: .touchUpInside)
        view.backgroundColor = contentView.backgroundColor
        let image = Asset.heart.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        let selectedImage = Asset.heartFill.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        view.tintColor = getLikeButtonTintColor(isSelected: false)
        view.contentMode = .scaleAspectFit
        view.imageView?.contentMode = .scaleAspectFit
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.setTitleColor(Asset.textColor.color, for: .selected)
        
        view.setImage(image, for: .normal)
        view.setImage(selectedImage, for: .selected)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 24)
        view.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: -8)
        
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "shareButton"
        view.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
        view.backgroundColor = contentView.backgroundColor
        let image = Asset.share.image
            .resizeImage(to: 32, aspectRatio: .current)
            .withRenderingMode(.alwaysTemplate)
        view.tintColor = Asset.other0.color
        view.contentMode = .scaleAspectFit
        view.imageView?.contentMode = .scaleAspectFit
        
        view.setImage(image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = .clear
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
        contentView.addSubview(shadowView)
        contentView.addSubview(bottomBackgroundView)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
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
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),
            
            bottomBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBackgroundView.topAnchor.constraint(equalTo: likeButton.topAnchor),
            bottomBackgroundView.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            likeButton.heightAnchor.constraint(equalToConstant: 44),
            
            shareButton.topAnchor.constraint(equalTo: likeButton.topAnchor),
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor),
            shareButton.heightAnchor.constraint(equalTo: likeButton.heightAnchor),
            
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shadowView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            shadowView.topAnchor.constraint(equalTo: bottomBackgroundView.bottomAnchor),
            shadowView.heightAnchor.constraint(equalToConstant: 2)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MatchResultTableCell: ConfigurableCell {
    
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        dateLabel.text = data.date
        statusLabel.text = data.status
        stadiumLabel.text = data.stadium
        
        scoreLabel.text = data.score
        homeTeamLabel.text = data.homeTeam
        awayTeamLabel.text = data.awayTeam
        
        typeLabel.text = data.type
        titleLabel.text = data.title
        
        contentView.backgroundColor = data.backgroundColor
        titleLabel.backgroundColor = data.backgroundColor
        titleLabel.textColor = data.textColor
        
        dateLabel.backgroundColor = data.backgroundColor
        statusLabel.backgroundColor = data.backgroundColor
        stadiumLabel.backgroundColor = data.backgroundColor
        
        scoreLabel.backgroundColor = data.backgroundColor
        scoreLabel.textColor = data.textColor
        
        homeTeamLabel.backgroundColor = data.backgroundColor
        homeTeamLabel.textColor = data.textColor
        
        awayTeamLabel.backgroundColor = data.backgroundColor
        awayTeamLabel.textColor = data.textColor
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        
        FirebaseManager.shared.databaseManager.getEventLikeInfo(eventID: data.uid) { (count, userLikes) in
            DispatchQueue.main.async {
                self.likeButton.setTitle("\(count)", for: .normal)
                self.likeButton.setTitle("\(count)", for: .selected)
                self.likeButton.isSelected = userLikes
                self.likeButton.tintColor = self.getLikeButtonTintColor(isSelected: userLikes)
                self.data?.likesCount = count
            }
        }
        
    }
    
}

extension MatchResultTableCell {
    @objc
    private func handleLikeAction() {
        likeButton.isSelected.toggle()
        likeButton.tintColor = getLikeButtonTintColor(isSelected: likeButton.isSelected)
        data?.likeAction(likeButton.isSelected)
        self.data?.likesCount += (likeButton.isSelected ? 1 : -1)
        likeButton.setTitle("\(self.data?.likesCount ?? 0)", for: .normal)
        likeButton.setTitle("\(self.data?.likesCount ?? 0)", for: .selected)
    }
    
    @objc
    private func handleShareAction() {
        self.shareButton.isSelected.toggle()
        data?.shareAction()
    }
    
    private func getLikeButtonTintColor(isSelected: Bool) -> UIColor {
        return isSelected ? Asset.accent0.color : Asset.other0.color
    }
}
