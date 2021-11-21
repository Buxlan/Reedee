//
//  EditEventInputDateCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/26/21.
//

import UIKit

class EditEventInputDateCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = DateCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 12.0
        let view = CorneredView(corners: [.topLeft, .topRight], radius: cornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dateTextField: UITextField = {
        let view = UITextField()
        view.placeholder = L10n.Events.editEventTitlePlaceholder
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont17
        view.autocorrectionType = .no
        view.inputAccessoryView = keyboardAccessoryView
        view.inputView = datePicker
        view.delegate = self
//        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return view
    }()
        
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.calendar = Calendar.current
        view.datePickerMode = .date
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        return view
    }()
    
    private var keyboardAccessoryView: KeyboardAccessoryDoneView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = KeyboardAccessoryDoneView(frame: frame)
        return view
    }()

    // MARK: - Lifecircle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isInterfaceConfigured = false
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        if isInterfaceConfigured { return }
        contentView.backgroundColor = Asset.other3.color
        tintColor = Asset.other1.color
        contentView.addSubview(roundedView)
        contentView.addSubview(dateTextField)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dateTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dateTextField.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            dateTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            dateTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            dateTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            roundedView.topAnchor.constraint(equalTo: dateTextField.topAnchor, constant: -4),
            roundedView.bottomAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputDateCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: data.date)
        
        dateTextField.text = dateString
        dateTextField.backgroundColor = data.textFieldBackgroundColor
        dateTextField.font = data.font
        dateTextField.textColor = data.textColor
        let placeholderText = NSAttributedString(string: L10n.EditEventLabel.datePlaceholer,
                                                 attributes: [NSAttributedString.Key.foregroundColor: data.placeholderColor])
        dateTextField.attributedPlaceholder = placeholderText
        roundedView.backgroundColor = data.textFieldBackgroundColor
        contentView.backgroundColor = data.backgroundColor
        var viewModel = KeyboardAccessoryDoneViewModel()
        viewModel.doneAction = {
            self.dateTextField.resignFirstResponder()
            let date = self.datePicker.date
            self.dateTextField.text = self.getString(from: date)
            self.data?.date = date
            self.data?.valueChanged(date)
        }
        keyboardAccessoryView.configure(data: viewModel)
        
        datePicker.backgroundColor = data.textFieldBackgroundColor
        datePicker.tintColor = Asset.textColor.color
    }    
    
}

extension EditEventInputDateCell: UITextFieldDelegate {
    
}

extension EditEventInputDateCell {
    
    private func getString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
}
