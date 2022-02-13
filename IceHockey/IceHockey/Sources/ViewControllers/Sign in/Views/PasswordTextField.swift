//
//  PasswordTextField.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import UIKit

class PasswordTextField: UITextField {
        
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = "passwordTextField"
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
        keyboardAppearance = .dark
        keyboardType = .default
        backgroundColor = Colors.Gray.light
        font = Fonts.Regular.subhead
        layer.cornerRadius = 8
        clipsToBounds = true
        isSecureTextEntry = true
        tintColor = Colors.Gray.dark
        let attr: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Colors.Gray.dark,
            NSAttributedString.Key.font: Fonts.Regular.subhead
        ]
        attributedPlaceholder = NSAttributedString(
            string: L10n.Auth.passwordPlaceholder,
            attributes: attr
        )
        self.setImage(Asset.lock.image.withRenderingMode(.alwaysTemplate))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 10)
    }
    
}

extension PasswordTextField {
    
    typealias DataType = TextInputCellModel
    func configure(data: DataType) {
        text = data.value
        backgroundColor = data.backgroundColor
        font = data.font
        tintColor = data.tintColor
        textColor = data.textColor
        let attr: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: data.tintColor,
            NSAttributedString.Key.font: data.font
        ]
        if data.placeholderText.isEmpty,
            let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: attr
            )
        } else if !data.placeholderText.isEmpty {
            attributedPlaceholder = NSAttributedString(
                string: data.placeholderText,
                attributes: attr
            )
        }
    }
}
