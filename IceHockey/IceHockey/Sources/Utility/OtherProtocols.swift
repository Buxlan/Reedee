//
//  OtherProtocols.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import Foundation

protocol InputData {
    associatedtype DataType
    var inputData: DataType? { get set }
}
