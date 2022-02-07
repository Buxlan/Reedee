//
//  TransactionListTableFooterView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import SnapKit

class TransactionListTableFooterView: UIView {
    
    // MARK: - Properties
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.layer.cornerRadius = 6
        view.backgroundColor = Asset.accent1.color
        view.textColor = Colors.Gray.ultraLight
        view.font = Fonts.Regular.subhead
        view.textAlignment = .center
        view.clipsToBounds = true
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
        addSubview(amountLabel)
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
        
        amountLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
    
    
}

// MARK: - Configuring

extension TransactionListTableFooterView {
    
    func configure(amount: Double) {
        amountLabel.text = L10n.Common.remain + ": \(amount)"
    }
    
}
