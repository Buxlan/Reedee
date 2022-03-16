//
//  DocumentTableCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import SnapKit

class DocumentTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = DocumentCellModel
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
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
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
    
    private lazy var decreaseAmountLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "decreaseAmountLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.title
        view.isHidden = true
        return view
    }()
    
    private lazy var commentLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "commentLabel"
        view.numberOfLines = 2
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
        decreaseAmountLabel.isHidden = true
        accessoryType = .none
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        
        configureViewHierarchy()
        
        if let data = data {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: data.document.date)
            
            orderLabel.text = "\(data.order)"
            orderLabel.textColor = data.textColor
            orderLabel.font = data.font
            
            nameLabel.text = data.document.type.title
            nameLabel.textColor = data.textColor
            nameLabel.font = data.font
            
            dateLabel.text = dateString
            dateLabel.textColor = data.textColor
            dateLabel.font = data.font
            
            numberLabel.text = data.document.number
            numberLabel.textColor = data.textColor
            numberLabel.font = data.font
            
            amountLabel.text = "\(data.document.amount)"
            amountLabel.textColor = data.textColor
            amountLabel.font = data.font
            
            if let operationDoc = data.document as? OperationDocument {
                decreaseAmountLabel.text = "\(operationDoc.decreaseAmount)"
                decreaseAmountLabel.textColor = data.textColor
                decreaseAmountLabel.font = data.font
                decreaseAmountLabel.isHidden = false
            }
            
            if let proxy = data.document as? DocumentProxy,
               let operationDoc = proxy.object as? OperationDocument {
                decreaseAmountLabel.text = "\(operationDoc.decreaseAmount)"
                decreaseAmountLabel.textColor = data.textColor
                decreaseAmountLabel.font = data.font
                decreaseAmountLabel.isHidden = false
            }
            
            commentLabel.text = "\(data.document.comment)"
            commentLabel.textColor = data.textColor
            commentLabel.font = data.font
            
            typeImageView.image = data.document.type.image.withRenderingMode(.alwaysTemplate)
            
            switch data.document.type {
            case .operation:
                typeImageView.tintColor = .orange
            case .increase:
                typeImageView.tintColor = .green
            case .decrease:
                typeImageView.tintColor = .red
            }
            
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
        contentView.addSubview(dateLabel)
        contentView.addSubview(decreaseAmountLabel)
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
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.height.equalTo(16)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeImageView.snp.trailing).offset(16)
            make.trailing.equalTo(amountLabel.snp.leading).offset(-8).priority(500)
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
        }
        
        decreaseAmountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(80)
            make.top.equalTo(amountLabel.snp.bottom).offset(4)
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
extension DocumentTableCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
