//
//  OperationDocumentTableRowTableCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import SnapKit

class OperationDocumentTableRowTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = OperationDocumentTableRowCellModel
    var data: DataType?
    
    private var isInterfaceConfigured = false
    
    private lazy var orderLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "orderLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        return view
    }()
    
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
        view.accessibilityIdentifier = "numberLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "amountLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.title
        return view
    }()
    
    private lazy var commentLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "commentLabel"
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
        
        configureViewHierarchy()
        
        if let data = data {
            
            orderLabel.text = "\(data.row.index)"
            orderLabel.textColor = data.textColor
            orderLabel.font = data.font
            
            nameLabel.text = data.row.name + " " + data.row.surname
            nameLabel.textColor = data.textColor
            nameLabel.font = data.font
            
            numberLabel.text = data.row.number
            numberLabel.textColor = data.textColor
            numberLabel.font = data.font
            
            amountLabel.text = "\(data.row.amount)"
            amountLabel.textColor = data.textColor
            amountLabel.font = data.font
            
            commentLabel.text = "\(L10n.Document.comment): \(data.row.comment)"
            commentLabel.textColor = data.textColor
            commentLabel.font = data.font
            
            typeImageView.image = data.row.type.image.withRenderingMode(.alwaysTemplate)
            
            typeImageView.tintColor = data.row.type == .income ? .green : .red
            
            contentView.backgroundColor = data.backgroundColor
            
            orderLabel.isHidden = !data.isShowOrder
            setTypeImageViewConstraints()
        }
    }
    
    private func configureViewHierarchy() {
        guard contentView.subviews.isEmpty else {
            return
        }
        contentView.addSubview(orderLabel)
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
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(16)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.height.equalTo(16)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }
        
        orderLabel.snp.makeConstraints { make in
            make.centerX.equalTo(typeImageView)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        setTypeImageViewConstraints()
    }
    
    private func setTypeImageViewConstraints() {
        
        switch orderLabel.isHidden {
        case true:
            typeImageView.snp.removeConstraints()
            typeImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.centerY.equalToSuperview()
                make.height.equalTo(24)
                make.width.equalTo(24)
            }
         case false:
            typeImageView.snp.removeConstraints()
            typeImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(15)
                make.top.equalTo(orderLabel.snp.bottom).offset(8)
                make.height.equalTo(24)
                make.width.equalTo(24)
            }
        }
        
    }
    
}

// MARK: - ConfigurableCell extension
extension OperationDocumentTableRowTableCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
