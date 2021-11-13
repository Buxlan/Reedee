//
//  EditEventTextCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventInputTextCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = EventDetailDescriptionCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private var photoAccessoryView: KeyboardAccessoryPhotoView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = KeyboardAccessoryPhotoView(frame: frame)
        return view
    }()
        
    private lazy var eventTextField: UITextView = {
        let view = UITextView()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont14
        view.autocorrectionType = .no
        view.inputAccessoryView = photoAccessoryView
        view.keyboardAppearance = .light
        view.keyboardType = .default
        view.delegate = self
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel4"
        view.numberOfLines = 2
        view.text = L10n.Events.inputTextTitle
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont16
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
        contentView.addSubview(eventTextField)
        configureConstraints()
        isInterfaceConfigured = true
        photoAccessoryView.cameraButton.addTarget(self, action: #selector(cameraButtonHandle), for: .touchUpInside)
        photoAccessoryView.galleryButton.addTarget(self, action: #selector(galleryButtonHandle), for: .touchUpInside)
        photoAccessoryView.doneButton.addTarget(self, action: #selector(doneButtonHandle), for: .touchUpInside)
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            eventTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            eventTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            eventTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventTextField.heightAnchor.constraint(equalToConstant: 150)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputTextCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        eventTextField.text = data.title
    }
    
}

extension EditEventInputTextCell: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        handler?.setText(textView.text)
    }
    
}

extension EditEventInputTextCell {
    
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
        eventTextField.resignFirstResponder()
    }
    
}
