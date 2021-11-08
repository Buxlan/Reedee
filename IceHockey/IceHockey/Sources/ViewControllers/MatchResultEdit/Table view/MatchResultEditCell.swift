//
//  MatchResultEditCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/7/21.
//

import UIKit

class MatchResultEditCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = MatchResultEditCellModel
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
    
    private lazy var homeTeamTextView: TextViewWithPlaceholder = {
        let view = TextViewWithPlaceholder()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
        view.autocorrectionType = .no
        view.keyboardAppearance = .dark
        view.keyboardType = .default
        view.isScrollEnabled = false
        view.delegate = self
        view.maxLength = 40
        view.placeholder = L10n.EditEventLabel.homeTeamPlaceholder
        view.inputAccessoryView = keyboardAccessoryView
        return view
    }()
    
    private lazy var awayTeamTextView: TextViewWithPlaceholder = {
        let view = TextViewWithPlaceholder()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
        view.autocorrectionType = .no
        view.keyboardAppearance = .dark
        view.keyboardType = .default
        view.isScrollEnabled = false
        view.delegate = self
        view.maxLength = 40
        view.placeholder = L10n.EditEventLabel.awayTeamPlaceholder
        view.inputAccessoryView = keyboardAccessoryView
        return view
    }()
    
    private lazy var homeTeamScoreTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "homeTeamScoreTextField"
        view.placeholder = L10n.EditEventLabel.scorePlaceholder
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardAppearance = .dark
        view.keyboardType = .numberPad
        view.font = .regularFont50
        view.autocorrectionType = .no
        view.delegate = self
        view.placeholder = "0"
        return view
    }()
    
    private lazy var awayTeamScoreTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "awayTeamScoreTextField"
        view.placeholder = L10n.EditEventLabel.scorePlaceholder
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont50
        view.autocorrectionType = .no
        view.delegate = self
        view.keyboardAppearance = .dark
        view.keyboardType = .numberPad
        view.placeholder = "0"
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
    
    private lazy var titleTextView: TextViewWithPlaceholder = {
        let view = TextViewWithPlaceholder()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        view.autocorrectionType = .no
        view.keyboardAppearance = .dark
        view.keyboardType = .default
        view.delegate = self
        view.isScrollEnabled = true
        view.placeholder = L10n.EditEventLabel.titlePlaceholder
        view.inputAccessoryView = keyboardAccessoryView
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
        contentView.addSubview(homeTeamTextView)
        contentView.addSubview(awayTeamTextView)
        contentView.addSubview(homeTeamScoreTextField)
        contentView.addSubview(awayTeamScoreTextField)
        contentView.addSubview(titleTextView)
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
            
            homeTeamTextView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 0),
            homeTeamTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamTextView.trailingAnchor.constraint(equalTo: centerStackView.leadingAnchor, constant: -16),
            homeTeamTextView.bottomAnchor.constraint(equalTo: homeTeamScoreTextField.topAnchor),
                    
            awayTeamTextView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 0),
            awayTeamTextView.leadingAnchor.constraint(equalTo: centerStackView.trailingAnchor, constant: 8),
            awayTeamTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamTextView.heightAnchor.constraint(equalTo: centerStackView.heightAnchor),
                       
            centerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            centerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            centerStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            centerStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25, constant: -16),
            
            scoreLabel.topAnchor.constraint(equalTo: homeTeamScoreTextField.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor, constant: 8),
            scoreLabel.trailingAnchor.constraint(equalTo: centerStackView.trailingAnchor, constant: -16),
            scoreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            homeTeamScoreTextField.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 32),
            homeTeamScoreTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            homeTeamScoreTextField.trailingAnchor.constraint(equalTo: centerStackView.leadingAnchor, constant: -16),
            homeTeamScoreTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            awayTeamScoreTextField.topAnchor.constraint(equalTo: homeTeamScoreTextField.topAnchor),
            awayTeamScoreTextField.leadingAnchor.constraint(equalTo: centerStackView.trailingAnchor, constant: 8),
            awayTeamScoreTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            awayTeamScoreTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            titleTextView.topAnchor.constraint(equalTo: homeTeamScoreTextField.bottomAnchor, constant: 8),
            titleTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleTextView.bottomAnchor.constraint(lessThanOrEqualTo: likeButton.topAnchor, constant: -8),
            titleTextView.heightAnchor.constraint(equalToConstant: 80),
            
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

extension MatchResultEditCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        
        self.data = data
        
        dateLabel.text = data.date
        statusLabel.text = data.status
        stadiumLabel.text = data.stadium.isEmpty ? "Stadium" : data.stadium
        
        homeTeamScoreTextField.text = "\(data.homeTeamScore)"
        awayTeamScoreTextField.text = "\(data.awayTeamScore)"
        homeTeamScoreTextField.textColor = data.textColor
        awayTeamScoreTextField.textColor = data.textColor
        
        homeTeamTextView.text = data.homeTeam
        awayTeamTextView.text = data.awayTeam
        
        typeLabel.text = data.type
        titleTextView.text = data.title
        
        contentView.backgroundColor = data.backgroundColor
        titleTextView.textColor = data.textColor
        
        centerStackView.backgroundColor = data.backgroundColor
        dateLabel.backgroundColor = data.backgroundColor
        statusLabel.backgroundColor = data.backgroundColor
        stadiumLabel.backgroundColor = data.backgroundColor

        homeTeamTextView.textColor = data.textColor
        awayTeamTextView.textColor = data.textColor
        
        typeLabel.backgroundColor = data.typeBackgroundColor
        typeLabel.textColor = data.typeTextColor
        typeLabel.text = data.type
        
        likeButton.backgroundColor = data.backgroundColor
        shareButton.backgroundColor = data.backgroundColor
        bottomBackgroundView.backgroundColor = data.backgroundColor
        
        setInputViewBackgroundColor()
        
    }
    
}

extension MatchResultEditCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let data = data else { return }
        var text = ""
        if let value = textField.text {
            text = value
        }
        switch textField {
        case homeTeamScoreTextField:
            data.setHomeTeamScoreAction(Int(text) ?? 0)
        case awayTeamScoreTextField:
            data.setAwayTeamScoreAction(Int(text) ?? 0)
        default:
            break
        }
    }
    
}

extension MatchResultEditCell: UITextViewDelegate {
        
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        guard let data = data else { return }
        textView.backgroundColor = valueIsValid(for: textView) ? data.backgroundColor : Asset.wrongValue.color
        switch textView {
        case homeTeamTextView:
            data.setHomeTeamAction(textView.text)
        case awayTeamTextView:
            data.setAwayTeamAction(textView.text)
        case titleTextView:
            data.setTitleAction(textView.text)
        default:
            break
        }
    }
    
}

extension MatchResultEditCell {
    
    func setInputViewBackgroundColor() {
        guard let data = data else { return }
        homeTeamTextView.backgroundColor = valueIsValid(for: homeTeamTextView) ? data.backgroundColor : data.backgroundColor
        awayTeamTextView.backgroundColor = valueIsValid(for: awayTeamTextView) ? data.backgroundColor : data.backgroundColor
        titleTextView.backgroundColor = valueIsValid(for: titleTextView) ? data.backgroundColor : data.backgroundColor
        homeTeamScoreTextField.backgroundColor = valueIsValid(for: homeTeamScoreTextField) ? data.backgroundColor : data.backgroundColor
        awayTeamScoreTextField.backgroundColor = valueIsValid(for: awayTeamScoreTextField) ? data.backgroundColor : data.backgroundColor
    }
    
    func valueIsValid(for view: UIView) -> Bool {
        var value: String = ""
        if let view = view as? UITextField {
            value = view.text ?? ""
        } else if let view = view as? UITextView {
            value = view.text
        }
        if value.isEmpty { return false }
        if view === homeTeamScoreTextField || view === awayTeamScoreTextField {
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
