//
//  FirebaseObjectRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Foundation

protocol FirebaseObjectRemover {
    var object: FirebaseObject { get }
    func remove(completionHandler: @escaping () -> Void) throws
}
