//
//  EditOperationDocumentHeaderView.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import SnapKit
import FSCalendar

protocol KeyboardAccessoryViewProtocol {
    func getKeyboardAccessoryView() -> UIView?
}

protocol EditOperationDocHeaderViewDelegate: AnyObject {
    func onSelectDate()
    func didChanged(number: String)
    func didChanged(comment: String)
}

class EditOperationDocHeaderView: UIView {
    
    // MARK: - Properties
    
    static let height: CGFloat = 135.0
    
    weak var delegate: EditOperationDocHeaderViewDelegate?
    
    private lazy var dateButton: DatePickerButton = {
        let view = DatePickerButton()
        view.onSelect = { [weak self] in
            self?.delegate?.onSelectDate()
        }
        return view
    }()
    
    private lazy var numberWrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.Gray.medium.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var numberTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.textColor = .black
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Operation.numberPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead]
        )
        return view
    }()
    
    private lazy var commentTextView: UITextView = {
        let view = TextViewWithPlaceholder()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.Gray.medium.cgColor
        view.textColor = .black
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.placeholder = L10n.Document.Operation.commentPlaceholder
        view.isEditable = true
        view.font = Fonts.Regular.subhead
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Operation.commentPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead])
        view.backgroundColor = .white
        view.delegate = self
        view.inputAccessoryView = keyboardAccessoryView
        
        return view
    }()
    
    private lazy var keyboardAccessoryView: DoneKeyboardAccessoryView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = DoneKeyboardAccessoryView(frame: frame)
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecircle
    
    init(delegate: EditOperationDocHeaderViewDelegate,
         frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        addSubview(dateButton)
        addSubview(numberWrapperView)
        numberWrapperView.addSubview(numberTextField)
        addSubview(commentTextView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configure(data: DetailDocumentHeaderViewModel) {
        
        let document = data.document
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .long
        let dateStr = dateFormatter.string(from: document.date)
        
        dateButton.setTitle(dateStr, for: .normal)
        
        numberTextField.text = "\(document.number)"
        numberTextField.textColor = data.textColor
        numberTextField.font = data.font
        
        commentTextView.text = "\(document.comment)"
        commentTextView.textColor = data.textColor
        commentTextView.font = data.font
        
        self.backgroundColor = data.backgroundColor
    
    }
    
    func didEndEditing() {
        if numberTextField.isFirstResponder {
            commentTextView.becomeFirstResponder()
        }
        if commentTextView.isFirstResponder {
            commentTextView.resignFirstResponder()
        }
    }
    
    func configureDatePickerButton(startDate: Date?, endDate: Date?) {
        dateButton.configure(startDate: startDate, endDate: endDate)
    }
    
    private func configureConstraints() {
        
        dateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.width.lessThanOrEqualToSuperview()
        }
        
        numberWrapperView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateButton.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(numberTextField.snp.bottom).offset(8)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
}

extension EditOperationDocHeaderView: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        delegate?.didChanged(number: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }
        delegate?.didChanged(comment: text)
    }
    
}

// MARK: - Actions

extension EditOperationDocHeaderView {
    
    @objc private func selectDateHandle() {
        delegate?.onSelectDate()
    }
    
}

// MARK: - DoneKeyboardAccessoryViewDelegate

extension EditOperationDocHeaderView: DoneKeyboardAccessoryViewDelegate {
    
    func onDone() {
        if numberTextField.isFirstResponder {
            commentTextView.becomeFirstResponder()
        } else if commentTextView.isFirstResponder {
            commentTextView.resignFirstResponder()
        }
    }
    
}
