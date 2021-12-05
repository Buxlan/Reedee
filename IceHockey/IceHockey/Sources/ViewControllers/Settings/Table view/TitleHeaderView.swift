//
//  TitleHeaderView.swift
//  IceHockey
//
//  Created by  Buxlan on 12/5/21.
//

import SnapKit

class TitleHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = AuthHeaderModel
    var data: DataType?
    
    private lazy var dataLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        return view
    }()
        
    // MARK: - Lifecircle
        
    // MARK: - Helper functions
    
    func configureUI() {
        createViewHierarchy()
        if let data = data {
            dataLabel.text = data.title
            dataLabel.textColor = Asset.other3.color
            contentView.backgroundColor = Asset.accent0.color
            dataLabel.backgroundColor = Asset.accent0.color
        }
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(dataLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-64)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(32)
        }
    }
    
}

// MARK: - ConfigurableCollectionContent extension
extension TitleHeaderView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
