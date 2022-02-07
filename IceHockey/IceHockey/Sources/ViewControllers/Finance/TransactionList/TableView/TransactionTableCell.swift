//
//  TransactionTableCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import SnapKit

class TransactionTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var data: DataType?
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "nameLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "nameLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "nameLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.title
        return view
    }()
    
    private lazy var commentLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "nameLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.body
        return view
    }()
        
    private lazy var typeImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "typeImageView"
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.isHidden = false
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        typeImageView.image = nil
        typeImageView.isHidden = false
        accessoryType = .none
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if let data = data {
            nameLabel.text = data.name
            nameLabel.textColor = data.textColor
            nameLabel.font = data.font
            
            numberLabel.text = data.number
            numberLabel.textColor = data.textColor
            numberLabel.font = data.font
            
            amountLabel.text = "\(data.amount)"
            amountLabel.textColor = data.textColor
            amountLabel.font = data.font
            
            commentLabel.text = "\(data.comment)"
            commentLabel.textColor = data.textColor
            commentLabel.font = data.font
            
            typeImageView.image = data.type.image.withRenderingMode(.alwaysTemplate)
            
            typeImageView.tintColor = data.type == .income ? .green : .red
            
            contentView.backgroundColor = data.backgroundColor
        }
        configureViewHierarchy()
    }
    
    private func configureViewHierarchy() {
        guard contentView.subviews.isEmpty else {
            return
        }
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(typeImageView)
        contentView.addSubview(commentLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(24)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(24)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
        }
        
        typeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
    }
    
}

// MARK: - ConfigurableCell extension
extension TransactionTableCell: ConfigurableCollectionContent {
        
    typealias DataType = TransactionCellModel
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
