//
//  EditDocSectionFooterView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 09.03.2022.
//

import SnapKit

class EditDocSectionFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = DetailDocSectionFooterViewModel
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
            
            switch data.type {
            case .income:
                dataLabel.text = ("\(L10n.Finance.Transactions.increases): \(data.amount) \(L10n.Finance.currency)")
            case .cost:
                dataLabel.text = ("\(L10n.Finance.Transactions.decreases): \(data.amount) \(L10n.Finance.currency)")
            }

            dataLabel.textColor = data.textColor
            contentView.backgroundColor = data.backgroundColor
            dataLabel.backgroundColor = data.backgroundColor
        }
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(dataLabel)
        contentView.addSubview(lineView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        dataLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
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

extension EditDocSectionFooterView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
    var height: CGFloat {
        return 80.0
    }
    
}
