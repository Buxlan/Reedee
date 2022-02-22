//
//  DetailDocumentTableSectionHeaderView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 20.02.2022.
//

import SnapKit

class DetailDocumentTableSectionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = DetailDocumentTableSectionHeaderViewModel
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
    
    private lazy var dataLabel2: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dataLabel2"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Bold.subhead
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray.dark
        return view
    }()
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
    func configureUI() {
        createViewHierarchy()
        if let data = data {
            dataLabel.text = ("Приход: \(data.plusAmount) руб.")

            dataLabel.textColor = data.textColor
            contentView.backgroundColor = data.backgroundColor
            dataLabel.backgroundColor = data.backgroundColor
            
            dataLabel2.text = ("Расход: \(data.minusAmount) руб.")

            dataLabel2.textColor = data.textColor
            contentView.backgroundColor = data.backgroundColor
            dataLabel2.backgroundColor = data.backgroundColor
        }
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(dataLabel)
        contentView.addSubview(dataLabel2)
        contentView.addSubview(lineView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        dataLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-64)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.height.equalTo(32)
        }
        
        dataLabel2.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-64)
            make.top.equalTo(dataLabel.snp.bottom).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(32)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
    }
    
}

// MARK: - ConfigurableCollectionContent extension
extension DetailDocumentTableSectionHeaderView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
    var height: CGFloat {
        return 80.0
    }
    
}
