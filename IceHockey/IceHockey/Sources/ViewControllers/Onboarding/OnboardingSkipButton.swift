//
//  OnboardingSkipButton.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import UIKit

class OnboardingSkipButton: UIButton {
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        
        setTitleColor(Asset.other1.color, for: .normal)
        backgroundColor = .clear
        
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // configure insets
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 40, bottom: 8, right: 40)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: -40)
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
