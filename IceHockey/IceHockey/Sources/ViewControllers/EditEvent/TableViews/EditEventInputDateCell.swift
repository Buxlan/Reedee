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
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel2"
        view.numberOfLines = 2
        view.text = L10n.Events.inputDateTitle
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
        return view
    }()
    
    private lazy var dateTextField: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        view.autocorrectionType = .no
        view.inputView = datePicker
        view.inputAccessoryView = keyboardAccessoryView
        view.keyboardAppearance = .light
        view.keyboardType = .default
//        view.delegate = self
        return view
    }()
        
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.calendar = Calendar.current
        view.datePickerMode = .date
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        view.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = UIDatePickerStyle.automatic
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateTextField)
        configureConstraints()
        isInterfaceConfigured = true
        var model = KeyboardAccessoryDoneViewModel()
        model.doneAction = {
            self.doneButtonHandle()
        }
        keyboardAccessoryView.configure(data: model)
    }
    
    internal func configureConstraints() {
        let datePickerBottomConstraint = dateTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        datePickerBottomConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            dateTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            dateTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateTextField.heightAnchor.constraint(equalToConstant: 44),
            datePickerBottomConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputDateCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
    }
    
    @objc
    private func dateChanged(_ sender: UIDatePicker) {
//        handler?.setDate(sender.date)
    }
    
}

extension EditEventInputDateCell {
    
    private func doneButtonHandle() {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        dateTextField.endEditing(false)
    }
    
}
