//
//  EditEventInputDateCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/26/21.
//

import UIKit

class EditEventInputDateCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = Date?
    
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
        
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.calendar = Calendar.current
        view.datePickerMode = .date
        view.backgroundColor = Asset.other3.color
        view.tintColor = Asset.textColor.color
        
        let currentDate = Date()
        var dateComponentMaximum = DateComponents()
        dateComponentMaximum.year = 1
        
        var dateComponentMinimum = DateComponents()
        dateComponentMinimum.year = -1
        
        view.maximumDate = Calendar.current.date(byAdding: dateComponentMaximum, to: currentDate)
        view.minimumDate = Calendar.current.date(byAdding: dateComponentMinimum, to: currentDate)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
               
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = UIDatePickerStyle.automatic
        }
        
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
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
        contentView.addSubview(datePicker)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let datePickerBottomConstraint = datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        datePickerBottomConstraint.priority = .defaultLow
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            datePickerBottomConstraint
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputDateCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType = nil) {
        configureUI()
    }
    
    @objc
    private func dateChanged(_ sender: UIDatePicker) {
//        handler?.setDate(sender.date)
    }
    
}
