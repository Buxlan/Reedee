//
//  DocumentCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.02.2022.
//

import UIKit

struct DocumentCellModel: TableCellModel, TintColorable {
    
    var document: Document
    var isShowOrder: Bool
    var order: Int
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(document: Document,
         isShowOrder: Bool = false,
         order: Int = 0) {
        self.document = document
        self.isShowOrder = isShowOrder
        self.order = order
        self.textColor = document.isActive ? self.textColor : Colors.Gray.medium
        log.debug("TransactionCellModel: text color is \(self.textColor)")
    }
    
}
