//
//  OperationDocumentTableRowCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import UIKit

struct OperationDocumentTableRowCellModel: TableCellModel, TintColorable {
    
    var row: OperationDocumentTableRow
    var isShowOrder: Bool
    var order: Int
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(data: OperationDocumentTableRow,
         isShowOrder: Bool = true,
         order: Int = 0) {
        self.row = data
        self.isShowOrder = isShowOrder
        self.order = order
        self.textColor = Asset.textColor.color
    }
    
}
