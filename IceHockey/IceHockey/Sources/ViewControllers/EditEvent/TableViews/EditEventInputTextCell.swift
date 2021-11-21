//
//  EditEventTextCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventInputTextCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = TextCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var roundedView: UIView = {
        let cornerRadius: CGFloat = 12.0
        let view = CorneredView(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var eventTextView: TextViewWithPlaceholder = {
        let view = TextViewWithPlaceholder()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .regularFont15
        view.autocorrectionType = .no
        view.inputAccessoryView = keyboardAccessoryView
        view.keyboardAppearance = .light
        view.keyboardType = .default
        view.delegate = self
        view.placeholder = L10n.EditEventLabel.awayTeamPlaceholder
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
        contentView.addSubview(eventTextView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            eventTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            eventTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            eventTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            eventTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            eventTextView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            roundedView.topAnchor.constraint(equalTo: eventTextView.topAnchor, constant: -4),
            roundedView.bottomAnchor.constraint(equalTo: eventTextView.bottomAnchor, constant: 4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventInputTextCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        self.data = data
        configureUI()
        eventTextView.text = data.text
        eventTextView.backgroundColor = data.textFieldBackgroundColor
        eventTextView.font = data.font
        eventTextView.textColor = data.textColor
        roundedView.backgroundColor = data.textFieldBackgroundColor
        contentView.backgroundColor = data.backgroundColor
        var viewModel = KeyboardAccessoryDoneViewModel()
        viewModel.doneAction = {
            self.resignFirstResponder()
            self.data?.valueChanged(self.eventTextView.text)
        }
        keyboardAccessoryView.configure(data: viewModel)        
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
        eventTextView.resignFirstResponder()
    }
    
}
