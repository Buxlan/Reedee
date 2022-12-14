//
//  TransactionCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

struct TransactionCellModel: TableCellModel, TintColorable {
    
    var transaction: FinanceTransactionProtocol
    var isShowOrder: Bool
    var order: Int
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(transaction: FinanceTransactionProtocol,
         isShowOrder: Bool = false,
         order: Int = 0) {
        self.transaction = transaction
        self.isShowOrder = isShowOrder
        self.order = order
        self.textColor = transaction.isActive ? self.textColor : Colors.Gray.medium
        log.debug("TransactionCellModel: text color is \(self.textColor)")
    }
    
}
