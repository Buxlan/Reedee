//
//  EditTransactionCell.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 08.03.2022.
//

import SnapKit

protocol EditTransactionCellDelegate: AnyObject {
    func didChanged(name: String, at index: Int)
    func didChanged(number: String, at index: Int)
    func didChanged(amount: Double, at index: Int)
    func didChanged(comment: String, at index: Int)
}

class EditTransactionCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: EditTransactionCellDelegate?
    
    typealias DataType = OperationDocumentTableRowCellModel
    var data: DataType?
    
    private var isInterfaceConfigured = false
    
    private lazy var checkBox: CheckBox = {
        let view = CheckBox()
        view.setTitle("", for: .normal)
        view.backgroundColor = .clear
        view.tintColor = Asset.textColor.color
        view.action = { [weak self] isSelected in
            
        }
        view.isHidden = true
        return view
    }()
    
    private lazy var orderLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "orderLabel"
        view.numberOfLines = 1
        view.textAlignment = .left
        view.font = Fonts.Regular.subhead
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "nameTextField"
        view.delegate = self
        view.textColor = .black
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Transaction.namePlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead]
        )
        return view
    }()
    
    private lazy var numberTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "numberTextField"
        view.delegate = self
        view.textColor = .black
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Transaction.numberPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead]
        )
        return view
    }()
    
    private lazy var amountTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "amountTextField"
        view.delegate = self
        view.textColor = .black
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Transaction.amountPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead]
        )
        return view
    }()
    
    private lazy var commentTextField: UITextField = {
        let view = UITextField()
        view.accessibilityIdentifier = "commentTextField"
        view.delegate = self
        view.textColor = .black
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Document.Transaction.commentPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
                         NSAttributedString.Key.font: Fonts.Regular.subhead]
        )
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        
        configureViewHierarchy()
        
        if let data = data {
            
            delegate = data.delegate
            
            orderLabel.text = "\(data.orderNumber)"
            orderLabel.textColor = data.textColor
            orderLabel.font = data.font
            
            var name = data.row.name + " " + data.row.surname
            if name == " " {
                name = ""
            }
            nameTextField.text = name
            nameTextField.textColor = data.textColor
            nameTextField.font = data.font
            
            numberTextField.text = data.row.number
            numberTextField.textColor = data.textColor
            numberTextField.font = data.font
            
            let amount = data.row.amount == 0.0 ? "" : "\(data.row.amount)"
            amountTextField.text = amount
            amountTextField.textColor = data.textColor
            amountTextField.font = data.font
            
            commentTextField.text = "\(data.row.comment)"
            commentTextField.textColor = data.textColor
            commentTextField.font = data.font
            
            contentView.backgroundColor = data.backgroundColor
            
            orderLabel.isHidden = !data.isShowOrder
        }
    }
    
    private func configureViewHierarchy() {
        guard contentView.subviews.isEmpty else {
            return
        }
        contentView.addSubview(orderLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(numberTextField)
        contentView.addSubview(amountTextField)
        contentView.addSubview(commentTextField)
        contentView.addSubview(checkBox)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        orderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        checkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(32)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(nameTextField.snp.bottom).offset(4)
            make.height.equalTo(32)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(16)
            make.width.equalTo(120)
            make.top.equalTo(numberTextField.snp.bottom).offset(4)
            make.height.equalTo(32)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(amountTextField.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(32)
        }
    }
    
}

// MARK: - ConfigurableCell extension
extension EditTransactionCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
}

// MARK: UITextField delegate
extension EditTransactionCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField === amountTextField,
              let textValue = textField.text {
            if Double(textValue) != nil {
                return true
            }
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let data = data else { return }
        
        switch textField {
        case nameTextField:
            delegate?.didChanged(name: text, at: data.index)
        case numberTextField:
            delegate?.didChanged(number: text, at: data.index)
        case commentTextField:
            delegate?.didChanged(comment: text, at: data.index)
        case amountTextField:
            delegate?.didChanged(amount: Double(text) ?? 0.0, at: data.index)
        default:
            assertionFailure()
            log.debug("Unknows textField")
        }
    }
}

// MARK: - DoneKeyboardAccessoryViewDelegate

extension EditTransactionCell: DoneKeyboardAccessoryViewDelegate {
    
    func onDone() {
        if nameTextField.isFirstResponder {
            numberTextField.becomeFirstResponder()
        } else if numberTextField.isFirstResponder {
            amountTextField.becomeFirstResponder()
        } else if amountTextField.isFirstResponder {
            commentTextField.becomeFirstResponder()
        } else if commentTextField.isFirstResponder {
            commentTextField.resignFirstResponder()
        }
    }
    
}
