//
//  ConfigurableLabel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/12/21.
//

import UIKit

protocol LabelModel {
    var text: String { get set }
    var font: UIFont { get set }
    var textColor: UIColor { get set }
    var backgroundColor: UIColor { get set }
}

struct DefaultLabelModel: LabelModel {
    var text = ""
    var font: UIFont = Fonts.Regular.body
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
}

struct LabelModelImpl: LabelModel {
    var text: String
    var font: UIFont = Fonts.Regular.body
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
}

class ConfigurableLabel: UILabel {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure(with: DefaultLabelModel())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConfigurableLabel {
    
    func configure(with data: LabelModel) {
        self.text = data.text
        self.font = data.font
        self.textColor = data.textColor
        self.backgroundColor = data.backgroundColor
    }
    
}
