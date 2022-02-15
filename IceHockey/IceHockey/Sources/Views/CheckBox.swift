//
//  CheckBox.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 15.02.2022.
//

import UIKit

class CheckBox: UIButton {

    var action: (Bool) -> Void = { _ in }

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configureInterface()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureInterface()
    }

    private func configureInterface() {
        
        let imageOff: UIImage = Asset.circle.image
            .resizeImage(to: 24.0, aspectRatio: .square)
            .withRenderingMode(.alwaysTemplate)
        let imageOn: UIImage = Asset.checkmarkCircle.image
            .resizeImage(to: 24.0, aspectRatio: .square)
            .withRenderingMode(.alwaysTemplate)
        
//        imageEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: -8)
        contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)

        setTitleColor(Asset.textColor.color, for: .normal)
        setTitleColor(Asset.textColor.color, for: .selected)
        setImage(imageOff, for: .normal)
        setImage(imageOn, for: .selected)
        titleLabel?.font = Fonts.Regular.subhead
        imageView?.contentMode = .scaleAspectFit
        
        addTarget(self, action: #selector(tappedHandle), for: .touchUpInside)
    }
    
    @objc private func tappedHandle() {
        isSelected.toggle()
        action(isSelected)
    }
    
}
