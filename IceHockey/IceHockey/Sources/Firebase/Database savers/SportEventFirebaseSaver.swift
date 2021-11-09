//
//  SportEventFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Firebase

protocol ObjectFirebaseSaver {
    associatedtype DataType
    var object: DataType { get }
    func save() throws
}

protocol SportEventFirebaseSaver: ObjectFirebaseSaver where DataType == SportEvent {
    
}

protocol SportTeamFirebaseSaver: ObjectFirebaseSaver where DataType == SportTeam {
    
}

protocol SportUserFirebaseSaver: ObjectFirebaseSaver where DataType == SportUser {
    
}
