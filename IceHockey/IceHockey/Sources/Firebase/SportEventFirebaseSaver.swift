//
//  SportEventFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Firebase

protocol SportEventFirebaseSaver {
    var event: SportEvent { get }
    func save(completionHandler: @escaping () -> Void) throws
}
