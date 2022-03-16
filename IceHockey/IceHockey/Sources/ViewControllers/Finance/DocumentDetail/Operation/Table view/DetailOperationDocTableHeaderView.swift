//
//  DetailOperationDocumentTableHeaderView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import SnapKit

class DetailOperationDocTableHeaderView: UIView {
    
    // MARK: - Properties
    
    static let height: CGFloat = 105.0
    
    var onAction = {}
    var onDateSelect = {}
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "nameLabel"
        view.numberOfLines = 3
        view.textAlignment = .center
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
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "dateLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var commentLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "commentLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.body
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
//        addSubview(dateLabel)
//        addSubview(numberLabel)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(lineView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configure(data: DetailDocumentHeaderViewModel) {
        
        let document = data.document
        
        nameLabel.text = document.view
        nameLabel.textColor = data.textColor
        nameLabel.font = data.font
        
        commentLabel.text = "\(L10n.Document.comment): \(document.comment)"
        commentLabel.textColor = data.textColor
        commentLabel.font = data.font
        
        self.backgroundColor = data.backgroundColor
    
    }
    
    private func configureConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        
    }
    
}

// MARK: - Actions

extension DetailOperationDocTableHeaderView {
    
    @objc private func addMeasureNoteHandle() {
        onAction()
    }
    
    @objc private func selectDateHandle() {
        onDateSelect()
    }
    
}
