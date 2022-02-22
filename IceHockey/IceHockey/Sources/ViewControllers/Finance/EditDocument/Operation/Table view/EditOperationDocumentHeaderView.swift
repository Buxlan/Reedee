//
//  EditOperationDocumentHeaderView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import SnapKit
import FSCalendar

class EditOperationDocumentHeaderView: UIView {
    
    // MARK: - Properties
    
    static let height: CGFloat = 135.0
    
    var onAction = {}
    var onDateSelect = {}
    
    private lazy var dateButton: DatePickerButton = {
        let view = DatePickerButton()
        view.onSelect = { [weak self] in
            self?.onDateSelect()
        }
        return view
    }()
    
    private lazy var addMeasureNoteButton: UIButton = {
        let color = Asset.textColor.color
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = color.cgColor
        view.setTitle("EMC.BUTTON.ADD_DRUG_INTAKE".localized(), for: .normal)
        view.setTitleColor(color, for: .normal)
        view.addTarget(self, action: #selector(addMeasureNoteHandle), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateButton)
        addSubview(addMeasureNoteButton)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configureDatePickerButton(startDate: Date?, endDate: Date?) {
        dateButton.configure(startDate: startDate, endDate: endDate)
    }
    
    private func configureConstraints() {
        
        dateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        
        addMeasureNoteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateButton.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
    }
    
}

// MARK: - Actions

extension EditOperationDocumentHeaderView {
    
    @objc private func addMeasureNoteHandle() {
        onAction()
    }
    
    @objc private func selectDateHandle() {
        onDateSelect()
    }
    
}
