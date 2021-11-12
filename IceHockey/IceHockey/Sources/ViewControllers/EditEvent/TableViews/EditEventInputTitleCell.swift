//
//  EditEventTitleTextFieldCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventInputTitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    typealias DataType = String?
    
    var isInterfaceConfigured: Bool = false
    
    private var photoAccessoryView: KeyboardAccessoryPhotoView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = KeyboardAccessoryPhotoView(frame: frame)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel3"
        view.numberOfLines = 2
        view.text = L10n.Events.inputTitle
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
        return view
    }()
        
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = L10n.Events.editEventTitlePlaceholder
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldFont16
        view.autocorrectionType = .no
        view.inputAccessoryView = photoAccessoryView
        view.delegate = self
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
        contentView.addSubview(titleTextField)
        configureConstraints()
        photoAccessoryView.cameraButton.addTarget(self, action: #selector(cameraButtonHandle), for: .touchUpInside)
        photoAccessoryView.galleryButton.addTarget(self, action: #selector(galleryButtonHandle), for: .touchUpInside)
        photoAccessoryView.doneButton.addTarget(self, action: #selector(doneButtonHandle), for: .touchUpInside)
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            titleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputTitleCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        titleTextField.text = data
    }
    
}

extension EditEventInputTitleCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
//            handler?.setTitle(text)
        }
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
