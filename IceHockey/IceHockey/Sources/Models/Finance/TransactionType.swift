//
//  TransactionType.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import UIKit

enum TransactionType: Int, Codable {
    
    case income
    case cost
    
    var image: UIImage {
        switch self {
        case .income:
            return Asset.plus.image
        case .cost:
            return Asset.minus.image
        }
    }
    
}
