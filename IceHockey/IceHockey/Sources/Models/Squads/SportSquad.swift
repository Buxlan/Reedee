//
//  HockeySquad.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Firebase

protocol Squad: FirebaseObject {
    var objectIdentifier: String { get set }
    var displayName: String { get set }
    var headCoach: String { get set }
}
