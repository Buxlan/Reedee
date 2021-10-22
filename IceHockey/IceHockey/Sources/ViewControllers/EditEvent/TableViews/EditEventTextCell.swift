//
//  EditEventTextCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTextCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = String?
    typealias HandlerType = EditEventHandler
    private var handler: HandlerType?
    
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
        contentView.addSubview(eventTextField)
        configureConstraints()
        isInterfaceConfigured = true
        photoAccessoryView.cameraButton.addTarget(self, action: #selector(cameraButtonHandle), for: .touchUpInside)
        photoAccessoryView.galleryButton.addTarget(self, action: #selector(galleryButtonHandle), for: .touchUpInside)
        photoAccessoryView.doneButton.addTarget(self, action: #selector(doneButtonHandle), for: .touchUpInside)
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            eventTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            eventTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            eventTextField.heightAnchor.constraint(equalToConstant: 250)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTextCell: ConfigurableActionCell {
    
    func configure(with data: DataType = nil, handler: HandlerType) {
        configureUI()
        eventTextField.text = data
        eventTextField.delegate = handler
        self.handler = handler
    }
    
}

extension EditEventTextCell {
    
    @objc
    private func cameraButtonHandle(_ sender: UIButton) {
        handler?.makePhoto()
    }
    
    @objc
    private func galleryButtonHandle(_ sender: UIButton) {
        handler?.openGallery()
    }
    
    @objc
    private func doneButtonHandle(_ sender: UIButton) {
        eventTextField.resignFirstResponder()
    }
    
}
