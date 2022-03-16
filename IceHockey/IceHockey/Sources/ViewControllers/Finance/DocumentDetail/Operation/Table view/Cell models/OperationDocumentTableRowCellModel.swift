//
//  OperationDocumentTableRowCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.02.2022.
//

import UIKit

struct OperationDocumentTableRowCellModel: TableCellModel, TintColorable {
    
    var row: OperationDocumentTableRow
    var index: Int
    var orderNumber: Int
    var isShowOrder: Bool
    
    weak var delegate: EditTransactionCellDelegate?
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(data: OperationDocumentTableRow,
         index: Int,
         orderNumber: Int,
         isShowOrder: Bool = true) {
        self.row = data
        self.isShowOrder = isShowOrder
        self.index = index
        self.textColor = Asset.textColor.color
        self.orderNumber = orderNumber
    }
    
}
