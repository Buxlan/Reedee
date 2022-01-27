//
//  ComponentStyle.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation
import UIKit

public class ComponentStyle: NSObject {
    
    public var textColor: UIColor
    public var textColorHighlighted: UIColor
    public var textColorDisabled: UIColor
    public var backgroundColor: UIColor
    public var backgroundColorHighlighted: UIColor
    
    public init(_ textColor: UIColor = Colors.Gray.dark,
                _ textColorHighlighted: UIColor = Colors.Gray.dark,
                _ textColorDisabled: UIColor = Colors.Gray.dark,
                _ backgroundColor: UIColor = Colors.Gray.ultraLight,
                _ backgroundColorHighlighted: UIColor = Colors.Gray.ultraLight) {
        self.textColor = textColor
        self.textColorHighlighted = textColorHighlighted
        self.textColorDisabled = textColorDisabled
        self.backgroundColor = backgroundColor
        self.backgroundColorHighlighted = backgroundColorHighlighted
    }

}

