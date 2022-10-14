//
//  AlertType.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

enum AlertType: CustomStringConvertible {
    case ok
    case cancel
    case close
    case custom(String)
    
    var description: String {
        switch self {
        case .ok:
            return L10n.Common.ok
        case .close:
            return L10n.Common.close
        case .cancel:
            return L10n.Common.cancel
        case .custom(let str):
            return str
        }
    }
    
}
