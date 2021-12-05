//
//  SettingTableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import SnapKit

class SettingTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    var data: DataType?
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        return view
    }()
        
    private lazy var disclosureImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "disclosureImageView"
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        let image = Asset.disclosure.image.withRenderingMode(.alwaysTemplate)
        view.setImage(image)
        view.isHidden = true
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
        disclosureImageView.isHidden = true
        accessoryType = .none
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if let data = data {
            dataLabel.text = data.title
            dataLabel.textColor = data.textColor
            dataLabel.font = data.font
            contentView.backgroundColor = data.backgroundColor
            disclosureImageView.tintColor = data.tintColor
            if data.hasDisclosure {
                disclosureImageView.isHidden = false
            }
        }
        createViewHierarchy()
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(dataLabel)
        contentView.addSubview(disclosureImageView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-96)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(32)
        }
        disclosureImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.centerY.equalTo(dataLabel.snp.centerY)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
    
}

// MARK: - ConfigurableCell extension
extension SettingTableCell: ConfigurableCollectionContent {
        
    typealias DataType = SettingCellModel
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
