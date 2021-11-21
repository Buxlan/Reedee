//
//  EditEventTitleTextFieldCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventInputTitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = TextCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 12.0
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = L10n.Events.editEventTitlePlaceholder
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont17
        view.autocorrectionType = .no
        view.inputAccessoryView = keyboardAccessoryView
        view.delegate = self
//        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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
        contentView.addSubview(titleTextField)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [            
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            titleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            titleTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: 44),
            roundedView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputTitleCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        titleTextField.text = data.text
        titleTextField.backgroundColor = data.textFieldBackgroundColor
        titleTextField.font = data.font
        titleTextField.textColor = data.textColor
        let placeholderText = NSAttributedString(string: L10n.Events.editEventTitlePlaceholder,
                                                 attributes: [NSAttributedString.Key.foregroundColor: data.placeholderColor])
        titleTextField.attributedPlaceholder = placeholderText
        roundedView.backgroundColor = data.textFieldBackgroundColor
        contentView.backgroundColor = data.backgroundColor
        var viewModel = KeyboardAccessoryDoneViewModel()
        viewModel.doneAction = {
            self.resignFirstResponder()
            guard let text = self.titleTextField.text else {
                return
            }
            self.data?.valueChanged(text)
        }
        keyboardAccessoryView.configure(data: viewModel)
    }
    
}

extension EditEventInputTitleCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        data?.valueChanged(text)
    }
    
}

extension EditEventInputTitleCell {
    
    @objc
    private func cameraButtonHandle(_ sender: UIButton) {
//        handler?.makePhoto()
    }
    
    @objc
    private func galleryButtonHandle(_ sender: UIButton) {
//        handler?.openGallery()
    }
    
    @objc
    private func doneButtonHandle(_ sender: UIButton) {
//        titleTextField.resignFirstResponder()
    }
    
}
