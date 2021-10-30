//
//  UniViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/30/21.
//

import Foundation
import CoreLocation

enum UniDataType {
    case int(Int)
    case string(String)
    case location(CLLocation)
}

protocol UniDataInterface {
    var value: UniDataType { get set }
    var config: [String: Any] { get set }
}

struct UniData: UniDataInterface {
    var value: UniDataType
    var config: [String: Any]
}

enum ViewType {
    case label
    case map
    case slider
    case textField
    case textView
}

protocol UniViewModel {
    var value: UniData { get }
    var viewType: ViewType { get }
}
