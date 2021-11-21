//
//  TextViewWithPlaceholder.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import Foundation
import UIKit

@IBDesignable
open class TextViewWithPlaceholder: UITextView {
    
    // MARK: - Properties
    
    // Maximum length of text. 0 means no limit.
    @IBInspectable open var maxLength: Int = 0
    
    // Customization
    @IBInspectable open var placeholder: String? {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable open var placeholderColor: UIColor = Asset.other0.color {
        didSet { setNeedsDisplay() }
    }
    open var attributedPlaceholder: NSAttributedString? {
        didSet { setNeedsDisplay() }
    }
    
    // MARK: - Lifecircle
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Helper methods
    
    private func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Show placeholder if needed
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if text.isEmpty {
            let xValue = textContainerInset.left + textContainer.lineFragmentPadding
            let yValue = textContainerInset.top
            let width = rect.size.width - xValue - textContainerInset.right
            let height = rect.size.height - yValue - textContainerInset.bottom
            let placeholderRect = CGRect(x: xValue, y: yValue, width: width, height: height)
            
            if let attributedPlaceholder = attributedPlaceholder {
                // Prefer to use attributedPlaceholder
                attributedPlaceholder.draw(in: placeholderRect)
            } else if let placeholder = placeholder {
                // Otherwise user placeholder and inherit `text` attributes
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = textAlignment
                var attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: placeholderColor,
                    .paragraphStyle: paragraphStyle
                ]
                if let font = font {
                    attributes[.font] = font
                }
                
                placeholder.draw(in: placeholderRect, withAttributes: attributes)
            }
        }
    }

    // Limit the length of text
    @objc func textDidChange(notification: Notification) {
        if let sender = notification.object as? TextViewWithPlaceholder, sender == self {
            if maxLength > 0 && text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                text = String(text[..<endIndex])
                undoManager?.removeAllActions()
            }
            setNeedsDisplay()
        }
    }
}
