//
//  DocumentType.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import UIKit

enum DocumentType: Int, Codable {
    
    case operation
    case increase
    case decrease
    
    var title: String {
        switch self {
        case .operation:
            return L10n.Document.Operation.title
        case .decrease:
            return L10n.Document.Decrease.title
        case .increase:
            return L10n.Document.Increase.title
        }
    }
    
    var image: UIImage {
        switch self {
        case .operation:
            return Asset.plusminus.image
        case .increase:
            return Asset.plus.image
        case .decrease:
            return Asset.minus.image
        }
    }
    
}
