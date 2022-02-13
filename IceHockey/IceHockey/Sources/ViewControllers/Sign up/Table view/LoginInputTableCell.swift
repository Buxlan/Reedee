//
//  LoginInputTableCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.02.2022.
//

import SnapKit
import RxSwift
import RxCocoa

class LoginInputTableCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = TextInputCellModel
    var data: DataType?
    
    private lazy var loginTextField: LoginTextField = {
        let view = LoginTextField()
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
    func configureUI() {
        if let data = data {
            loginTextField.configure(data: data)
            contentView.backgroundColor = data.contentViewBackgroundColor
        }
        createViewHierarchy()
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(loginTextField)
        configureConstraints()
    }
    
    private func configureConstraints() {
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).offset(-64)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.equalTo(40)
        }
    }
    
}

// MARK: - Text field delegate

extension LoginInputTableCell: UITextFieldDelegate {
    
    
    
}

// MARK: - ConfigurableCell extension
extension LoginInputTableCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}
