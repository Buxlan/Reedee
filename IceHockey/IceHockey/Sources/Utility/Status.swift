//
//  Status.swift
//  TMKTitanFramework
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.04.2022.
//

import Foundation

enum Status: CustomStringConvertible {
    case progress(String, String?)
    case alert(String, String, AlertType)
    case text(String, String?)
    case success(String, String, () -> Void)
    
    var description: String {
        switch self {
        case .progress(_, _):
            return "Progress"
        case .alert(_, _, _):
            return "Alert"
        case .text(_, _):
            return "Text"
        case .success(_, _, _):
            return "Success"
        }
    }
}
