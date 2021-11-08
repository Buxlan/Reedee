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
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .regularFont12
        return view
    }()
    
    private lazy var stadiumLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "stadiumLabel"
        view.textColor = Asset.other0.color
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
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .regularFont12
        return view
    }()
    
    private lazy var homeTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = .regularFont16
        return view
    }()
    
    private lazy var awayTeamLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = .regularFont16
        return view
    }()
    
    private lazy var homeTeamScoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "homeTeamScoreLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = .regularFont50
        return view
    }()
    
    private lazy var awayTeamScoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "awayTeamScoreLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.numberOfLines = 3
        view.textAlignment = .center
        view.font = .regularFont50
        return view
    }()
    
    private lazy var scoreLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "scoreLabel"
        view.textColor = Asset.other0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.textAlignment = .center
        view.numberOfLines = 1
        view.font = .regularFont50
        view.text = ":"
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
        let view = LikeButton()
        view.accessibilityIdentifier = "likeButton"
        view.backgroundColor = contentView.backgroundColor
        view.setTitle("0", for: .selected)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shareButton: ShareButton = {
        let view = ShareButton()
        view.backgroundColor = contentView.backgroundColor
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var keyboardAccessoryView: DoneKeyboardAccessoryView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = DoneKeyboardAccessoryView(frame: frame)
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
        keyboardAccessoryView.doneButton.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.heightAnchor.constraint(equalToConstant: 24),
            typeLabel.widthAnchor.constraint(equalToConstant: 100),
            
            homeTeamLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 0),
            homeTeamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamLabel.trailingAnchor.constraint(equalTo: centerStackView.leadingAnchor),
            homeTeamLabel.bottomAnchor.constraint(equalTo: homeTeamScoreLabel.topAnchor),
                    
            awayTeamLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 0),
            awayTeamLabel.leadingAnchor.constraint(equalTo: centerStackView.trailingAnchor),
            awayTeamLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamLabel.heightAnchor.constraint(equalTo: centerStackView.heightAnchor),
                       
            centerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
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
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 80),
            
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
        
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        
        setInputViewBackgroundColor()
        
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
    
    @objc private func handleDoneButton() {
        contentView.subviews.forEach { (view) in
            if view.isFirstResponder {
                view.resignFirstResponder()
                return
            }
        }
    }
    
}
