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
    let userImageHeight: CGFloat = 40.0
    
    var isInterfaceConfigured = false
    
    private lazy var userImageView: UIImageView = {
        let cornerRadius: CGFloat = 20.0
        let view = UIImageView()
        view.accessibilityIdentifier = "userImageView"
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private lazy var usernameLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "usernameLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var centerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 4
        view.addArrangedSubview(dateLabel)
        view.addArrangedSubview(stadiumLabel)
        view.addArrangedSubview(statusLabel)
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "typeLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.font = Fonts.Bold.subhead
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = Fonts.Regular.caption
        return view
    }()
    
    private lazy var stadiumLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "stadiumLabel"
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = Fonts.Regular.caption
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = Fonts.Regular.caption
        return view
    }()
    
    private lazy var homeTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var awayTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var homeTeamScoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamScoreLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = Fonts.Regular.scoreDisplay
        return view
    }()
    
    private lazy var awayTeamScoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamScoreLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = Fonts.Regular.scoreDisplay
        return view
    }()
    
    private lazy var scoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "scoreLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = Fonts.Regular.scoreDisplay
        view.text = ":"
        return view
    }()
    
    private lazy var titleLabel: InsetLabel = {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16)
        let view = InsetLabel(insets: insets)
        view.accessibilityIdentifier = "titleLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 5
        view.textAlignment = .left
        view.font = Fonts.Regular.body
        return view
    }()
    
    private lazy var likeButton: LikeButton = {
        let view = LikeButton()
        view.accessibilityIdentifier = "likeButton"
        view.setTitle("0", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleLikeAction), for: .touchUpInside)
        return view
    }()
    
    private lazy var shareButton: ShareButton = {
        let view = ShareButton()
        view.tintColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleShareAction), for: .touchUpInside)
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
    
    private lazy var noImage: UIImage = {
        Asset.noImage256.image.resizeImage(to: userImageHeight, aspectRatio: .current, with: .clear)
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
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(centerStackView)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(homeTeamScoreLabel)
        contentView.addSubview(awayTeamScoreLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(shadowView)
        contentView.addSubview(bottomBackgroundView)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(typeLabel)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: userImageHeight),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.heightAnchor.constraint(equalToConstant: userImageHeight),
            
            usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: -8),
            usernameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor),
            
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            typeLabel.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 4),
            typeLabel.heightAnchor.constraint(equalTo: userImageView.heightAnchor, constant: -8),
            
            homeTeamLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 4),
            homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamLabel.trailingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            homeTeamLabel.bottomAnchor.constraint(equalTo: homeTeamScoreLabel.topAnchor),
                    
            awayTeamLabel.topAnchor.constraint(equalTo: homeTeamLabel.topAnchor),
            awayTeamLabel.leadingAnchor.constraint(equalTo: centerStackView.trailingAnchor),
            awayTeamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamLabel.bottomAnchor.constraint(equalTo: homeTeamScoreLabel.topAnchor),
                       
            centerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centerStackView.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            centerStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            centerStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25, constant: -16),
            
            scoreLabel.topAnchor.constraint(equalTo: homeTeamScoreLabel.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: centerStackView.trailingAnchor),
            scoreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            homeTeamScoreLabel.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 32),
            homeTeamScoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamScoreLabel.trailingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            homeTeamScoreLabel.heightAnchor.constraint(equalTo: scoreLabel.heightAnchor),
            
            awayTeamScoreLabel.topAnchor.constraint(equalTo: homeTeamScoreLabel.topAnchor),
            awayTeamScoreLabel.leadingAnchor.constraint(equalTo: centerStackView.trailingAnchor),
            awayTeamScoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamScoreLabel.heightAnchor.constraint(equalTo: scoreLabel.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: homeTeamScoreLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            bottomBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bottomBackgroundView.topAnchor.constraint(equalTo: likeButton.topAnchor),
            bottomBackgroundView.bottomAnchor.constraint(equalTo: likeButton.bottomAnchor),
            
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
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

extension MatchResultTableCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        dateLabel.text = data.date
        statusLabel.text = data.status
        stadiumLabel.text = data.stadium.isEmpty ? "Stadium" : data.stadium
        
        homeTeamScoreLabel.text = "\(data.homeTeamScore)"
        awayTeamScoreLabel.text = "\(data.awayTeamScore)"
        homeTeamScoreLabel.textColor = data.textColor
        awayTeamScoreLabel.textColor = data.textColor
        
        homeTeamLabel.text = data.homeTeam
        awayTeamLabel.text = data.awayTeam
        
        typeLabel.text = data.type
        titleLabel.text = data.title
        
        usernameLabel.backgroundColor = data.backgroundColor
        userImageView.backgroundColor = data.backgroundColor
        usernameLabel.textColor = data.textColor
        
        contentView.backgroundColor = data.backgroundColor
        titleLabel.textColor = data.textColor
        
        centerStackView.backgroundColor = data.backgroundColor
        dateLabel.backgroundColor = data.backgroundColor
        statusLabel.backgroundColor = data.backgroundColor
        stadiumLabel.backgroundColor = data.backgroundColor

        homeTeamLabel.textColor = data.textColor
        awayTeamLabel.textColor = data.textColor
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        likeButton.titleLabel?.textColor = data.textColor
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        
        setInputViewBackgroundColor()
        
        self.usernameLabel.text = data.author
        self.userImageView.image = data.authorImage == nil ? noImage : data.authorImage
        
        self.likeButton.isSelected = data.likesInfo.isLiked
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: data.likesInfo.count)
        self.likeButton.configure(with: model)
        
    }
    
}

extension MatchResultTableCell {
    
    func setInputViewBackgroundColor() {
        guard let data = data else { return }
        homeTeamLabel.backgroundColor = valueIsValid(for: homeTeamLabel) ? data.backgroundColor : data.backgroundColor
        awayTeamLabel.backgroundColor = valueIsValid(for: awayTeamLabel) ? data.backgroundColor : data.backgroundColor
        titleLabel.backgroundColor = valueIsValid(for: titleLabel) ? data.backgroundColor : data.backgroundColor
        homeTeamScoreLabel.backgroundColor = valueIsValid(for: homeTeamScoreLabel) ? data.backgroundColor : data.backgroundColor
        awayTeamScoreLabel.backgroundColor = valueIsValid(for: awayTeamScoreLabel) ? data.backgroundColor : data.backgroundColor
    }
    
    func valueIsValid(for view: UIView) -> Bool {
        var value: String = ""
        if let view = view as? UITextField {
            value = view.text ?? ""
        } else if let view = view as? UITextView {
            value = view.text
        }
        if value.isEmpty { return false }
        if view === homeTeamScoreLabel || view === awayTeamScoreLabel {
            return Int(value) == nil ? false : true
        }
        return true
    }
    
    @objc private func handleLikeAction() {
        guard let data = self.data else { return }
        likeButton.isSelected.toggle()
        data.likeAction(likeButton.isSelected)
        let count = data.likesInfo.count + (likeButton.isSelected ? 1 : -1)
        self.data?.likesInfo.count = count
        let model = LikeButtonModelImpl(textColor: data.textColor,
                                        count: count)
        likeButton.configure(with: model)
    }
    
    @objc private func handleShareAction() {
        data?.shareAction()
    }
    
    private func getLikeButtonTintColor(isSelected: Bool) -> UIColor {
        return isSelected ? Asset.accent0.color : Asset.other0.color
    }
    
}
