//
//  DoneKeyboardAccessoryView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import UIKit

class DoneKeyboardAccessoryView: UIView {
    
    // MARK: - Properties
            
    lazy var doneButton: UIButton = {
        let width = self.frame.width
        let frame = CGRect(x: width,
                           y: 0,
                           width: 100,
                           height: 44)
        let view = UIButton(frame: frame)
        view.accessibilityIdentifier = "doneButton"
        view.backgroundColor = Asset.other0.color
        view.tintColor = Asset.other0.color
        view.setTitle(L10n.Other.done, for: .normal)
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        view.titleLabel?.font = .bxTitle3
        view.sizeToFit()
        view.frame = CGRect(x: width - view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: 44)
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Asset.other0.color
        self.addSubview(doneButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
}
