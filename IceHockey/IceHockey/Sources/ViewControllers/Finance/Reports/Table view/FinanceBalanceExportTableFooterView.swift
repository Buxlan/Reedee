//
//  FinanceBalanceExportTableFooterView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import SnapKit

class FinanceBalanceExportTableFooterView: UIView {
    
    // MARK: - Properties
    
    static let height: CGFloat = 80.0
    
    var onAction = {}
    
    private lazy var actionButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Common.export, for: .normal)
        view.layer.cornerRadius = 6
        view.backgroundColor = Asset.accent1.color
        view.setTitleColor(Colors.Gray.ultraLight, for: .normal)
        view.titleLabel?.font = Fonts.Regular.subhead
        view.addTarget(self, action: #selector(onActionHandle), for: .touchUpInside)
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
        addSubview(actionButton)
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
        
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
}

// MARK: - Actions

extension FinanceBalanceExportTableFooterView {
    
    @objc private func onActionHandle() {
        onAction()
    }
    
}
