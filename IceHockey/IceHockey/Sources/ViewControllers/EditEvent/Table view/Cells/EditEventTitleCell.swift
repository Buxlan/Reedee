//
//  EditEventTitleCell.swift
//  IceHockey
//
//  Created by  Buxlan on 10/21/21.
//

import UIKit

class EditEventTitleCell: UITableViewCell {
    
    // MARK: - Properties
    typealias DataType = TitleCellModel
    var data: DataType?
    
    var isInterfaceConfigured: Bool = false
    
    private lazy var roundedView: UIView = {        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var dataTextView: TextViewWithPlaceholder = {
        let view = TextViewWithPlaceholder()
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0.0
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autocorrectionType = .no
        view.inputAccessoryView = keyboardAccessoryView
        view.keyboardAppearance = .light
        view.keyboardType = .default
        view.delegate = self
        view.isScrollEnabled = false
        view.placeholder = L10n.EditEventLabel.titlePlaceholder
        return view
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(roundedView)
        contentView.addSubview(dataTextView)
        contentView.addSubview(borderView)
        configureConstraints()
        isInterfaceConfigured = true
    }
    
    internal func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            dataTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dataTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dataTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            dataTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dataTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            roundedView.topAnchor.constraint(equalTo: dataTextView.topAnchor, constant: -8),
            roundedView.bottomAnchor.constraint(equalTo: dataTextView.bottomAnchor, constant: 8),
            
            borderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            borderView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            borderView.heightAnchor.constraint(equalToConstant: 1),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension EditEventTitleCell: ConfigurableCollectionContent {
    
    func configure(with data: DataType) {
        configureUI()
        self.data = data
        dataTextView.text = data.text
        dataTextView.backgroundColor = data.lightBackgroundColor
        dataTextView.font = data.font
        dataTextView.textColor = data.textColor
        dataTextView.placeholderColor = data.placeholderColor
        roundedView.backgroundColor = data.lightBackgroundColor
        contentView.backgroundColor = data.backgroundColor
        borderView.backgroundColor = data.backgroundColor
        var viewModel = KeyboardAccessoryDoneViewModel()
        viewModel.doneAction = {
            self.dataTextView.endEditing(false)
            self.data?.valueChanged(self.dataTextView.text)
        }
        keyboardAccessoryView.configure(data: viewModel)
    }
    
}

extension EditEventTitleCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        data?.valueChanged(textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        data?.valueChanged(textView.text)
    }
    
}
