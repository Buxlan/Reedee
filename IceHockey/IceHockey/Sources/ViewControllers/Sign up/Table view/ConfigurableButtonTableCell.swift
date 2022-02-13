//
//  SignUpButtonTableCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.02.2022.
//

import SnapKit

class ConfigurableButtonTableCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = ButtonCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
        
    private lazy var button: UIButton = {
        let view = UIButton()
        view.accessibilityIdentifier = "saveButton"
        view.backgroundColor = Asset.other3.color
        view.setTitleColor(Asset.textColor.color, for: .normal)
        view.tintColor = Asset.textColor.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        view.setTitle(L10n.Events.save, for: .normal)
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
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
        contentView.addSubview(button)
        configureConstraints()
        isInterfaceConfigured = true
        button.addTarget(self, action: #selector(buttonHandle(_:)), for: .touchUpInside)
    }
    
    internal func configureConstraints() {
        button.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-64)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(40)
        }
    }
    
}

extension ConfigurableButtonTableCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        
        button.setTitle(data.text, for: .normal)
        button.setTitleColor(data.textColor, for: .normal)
        contentView.backgroundColor = data.contentViewBackgroundColor
        button.backgroundColor = data.backgroundColor
        button.titleLabel?.font = data.font
        
    }
    
}

extension ConfigurableButtonTableCell {
    
    @objc private func buttonHandle(_ sender: UIButton) {
        data?.action()
    }
}
