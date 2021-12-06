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
        placeholder = L10n.Auth.passwordPlaceholder
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
        keyboardAppearance = .dark
        keyboardType = .default
        backgroundColor = Colors.Gray.ultraLight
        font = Fonts.Regular.subhead
        layer.cornerRadius = 8
        clipsToBounds = true
        isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
}
