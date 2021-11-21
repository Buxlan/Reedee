//
//  EditEventBoldTextCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class EditEventInputBoldTextCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = TextCellModel
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
        view.autocorrectionType = .no
        view.inputAccessoryView = photoAccessoryView
        view.delegate = self
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.accessibilityIdentifier = "titleLabel5"
        view.numberOfLines = 2
        view.text = L10n.Events.inputBoldTextTitle
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont17
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
        photoAccessoryView.cameraButton.addTarget(self, action: #selector(cameraButtonHandle), for: .touchUpInside)
        photoAccessoryView.galleryButton.addTarget(self, action: #selector(galleryButtonHandle), for: .touchUpInside)
        photoAccessoryView.doneButton.addTarget(self, action: #selector(doneButtonHandle), for: .touchUpInside)
        configureConstraints()
        isInterfaceConfigured = true
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
            eventTextField.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputBoldTextCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        eventTextField.text = data.text
        eventTextField.font = .regularFont17
    }
    
}

extension EditEventInputBoldTextCell: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        handler?.setBoldText(textView.text)
    }
    
}

extension EditEventInputBoldTextCell {
    
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
