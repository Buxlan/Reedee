//
//  ProfileInfoTableCell.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 12/5/21.
//

import SnapKit

class ProfileInfoTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = ProfileInfoCellModel
    var data: DataType?
    
    private lazy var userImageButton: UIButton = {
        let view = UIButton()
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 32
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var usernameTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    
    private lazy var editUsernameButton: UIButton = {
        let view = UIButton()
        let image = Asset.edit.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image, for: .normal)
        return view
    }()
    
    private lazy var userIdentifierTextView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.textAlignment = .center
        return view
    }()
    
    private lazy var noImage: UIImage = Asset.logo.image
    
    private lazy var shadowView: ShadowCorneredView = {
        let view = ShadowCorneredView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBackgroundView: UIView = {
        let view = UIView()
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
        userImageButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        if let data = data {
            usernameTextView.text = data.username
            userIdentifierTextView.text = data.userIdentifier
            let avatar = data.image == nil ? noImage : data.image
            userImageButton.setImage(avatar, for: .normal)
            contentView.backgroundColor = data.backgroundColor
            userImageButton.backgroundColor = data.backgroundColor
            usernameTextView.backgroundColor = data.backgroundColor
            usernameTextView.textColor = data.textColor
            usernameTextView.font = data.font
            userIdentifierTextView.backgroundColor = data.backgroundColor
            userIdentifierTextView.textColor = data.textColor
            userIdentifierTextView.font = data.userIdentifierFont
            editUsernameButton.backgroundColor = data.backgroundColor
            editUsernameButton.tintColor = data.tintColor
            self.tintColor = data.tintColor
            contentView.tintColor = data.tintColor
        }
        createViewHierarchy()
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(userImageButton)
        contentView.addSubview(usernameTextView)
        contentView.addSubview(editUsernameButton)
        contentView.addSubview(userIdentifierTextView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        userImageButton.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.4)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.4)
            make.top.equalTo(contentView.snp.top).offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        usernameTextView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        usernameTextView.snp.makeConstraints { make in
            let height: Int = 40
            make.top.equalTo(userImageButton.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            let size = usernameTextView.sizeThatFits(CGSize(width: Int(contentView.frame.width - 64),
                                                            height: height))
            make.width.equalTo(size.width)
            make.height.equalTo(40)
        }
        editUsernameButton.snp.makeConstraints { make in
            make.centerY.equalTo(usernameTextView.snp.centerY)
            make.leading.equalTo(usernameTextView.snp.trailing).offset(8)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        userIdentifierTextView.snp.makeConstraints { make in
            make.top.equalTo(usernameTextView.snp.bottom).offset(4)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.equalTo(contentView.snp.leading).offset(32)
            make.trailing.equalTo(contentView.snp.trailing).offset(-32)
            make.bottom.equalTo(contentView.snp.bottom)
            make.height.equalTo(32)
        }
    }
}

extension ProfileInfoTableCell: ConfigurableCollectionContent {
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
}
