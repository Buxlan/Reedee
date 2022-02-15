//
//  TransactionConfirmTableFooterView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import SnapKit

class TransactionConfirmTableFooterView: UIView {
    
    // MARK: - Properties
    
    var onConfirm = {}
    var onBack = {}
    
    private lazy var confirmButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Common.confirm, for: .normal)
        view.layer.cornerRadius = 6
        view.backgroundColor = Colors.Accent.blue
        view.setTitleColor(Colors.Gray.ultraLight, for: .normal)
        view.titleLabel?.font = Fonts.Regular.subhead
        view.addTarget(self, action: #selector(onConfirmHandle), for: .touchUpInside)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Common.back, for: .normal)
        view.layer.cornerRadius = 6
        view.backgroundColor = Colors.Accent.red
        view.setTitleColor(Colors.Gray.ultraLight, for: .normal)
        view.titleLabel?.font = Fonts.Regular.subhead
        view.addTarget(self, action: #selector(onBackHandle), for: .touchUpInside)
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Gray.dark
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineView)
        addSubview(confirmButton)
        addSubview(backButton)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func configureConstraints() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.centerX).offset(16)
            make.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.centerX).offset(-16)
            make.height.equalTo(44)
        }
        
    }
    
}

// MARK: - Actions

extension TransactionConfirmTableFooterView {
    
    @objc private func onConfirmHandle() {
        onConfirm()
    }
    
    @objc private func onBackHandle() {
        onBack()
    }
    
}
