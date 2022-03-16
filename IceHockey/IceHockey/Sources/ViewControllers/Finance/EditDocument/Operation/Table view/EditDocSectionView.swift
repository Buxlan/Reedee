//
//  EditOperationDocSectionView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.03.2022.
//

import SnapKit

class EditDocSectionView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    typealias DataType = DetailDocSectionHeaderViewModel
    var data: DataType?
    
    var onAppend = {}
    var onRemove = {}
    
    private lazy var addCommandButton: UIButton = {
        let image = Asset.plus.image.withRenderingMode(.alwaysTemplate)
        let view = UIButton()
        view.tintColor = Colors.Accent.blue
        view.setImage(image, for: .normal)
        view.addTarget(self, action: #selector(addCommandHandle),
                       for: .touchUpInside)
        return view
    }()
    
    private lazy var removeCommandButton: UIButton = {
        let image = Asset.minus.image.withRenderingMode(.alwaysTemplate)
        let view = UIButton()
        view.setImage(image, for: .normal)
        view.tintColor = Colors.Accent.red
        view.addTarget(self, action: #selector(removeComandHandle),
                       for: .touchUpInside)
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
            contentView.backgroundColor = data.backgroundColor
            onAppend = data.onAppend
            onRemove = data.onRemove
        }
    }
    
    private func createViewHierarchy() {
        if contentView.subviews.count != 0 {
            return
        }
        contentView.addSubview(addCommandButton)
        contentView.addSubview(removeCommandButton)
        contentView.addSubview(lineView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        addCommandButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        removeCommandButton.snp.makeConstraints { make in
            make.leading.equalTo(addCommandButton.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
    }
    
}

// MARK: Actions

extension EditDocSectionView {
    
    @objc private func addCommandHandle() {
        onAppend()
    }
    
    @objc private func removeComandHandle() {
        onRemove()
    }
    
}

// MARK: - ConfigurableCollectionContent extension

extension EditDocSectionView: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
    var height: CGFloat {
        return 80.0
    }
    
}

