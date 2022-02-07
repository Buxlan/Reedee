//
//  TransactionCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

struct TransactionCellModel: TableCellModel, TintColorable {
    
    var name: String
    var number: String
    var comment: String
    var type: TransactionType
    var amount: Double
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(transaction: FinanceTransaction) {
        self.name = transaction.name
        self.number = transaction.number
        self.comment = transaction.comment
        self.type = transaction.type
        self.amount = transaction.amount
    }
    
}
