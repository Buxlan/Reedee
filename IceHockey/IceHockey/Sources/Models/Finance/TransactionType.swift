//
//  TransactionType.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

enum TransactionType: Int, Codable, CustomStringConvertible {
    
    case income
    case cost
    
    var description: String {
        switch self {
        case .income:
            return L10n.Finance.Transactions.income
        case .cost:
            return L10n.Finance.Transactions.costs
        }
    }
    
    var image: UIImage {
        switch self {
        case .income:
            return Asset.plus.image
        case .cost:
            return Asset.minus.image
        }
    }
    
}
