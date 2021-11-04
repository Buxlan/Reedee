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
    func save(completionHandler: @escaping () -> Void) throws
}

protocol SportEventFirebaseSaver: ObjectFirebaseSaver where DataType == SportNews {
    
}

protocol SportTeamFirebaseSaver: ObjectFirebaseSaver where DataType == SportTeam {
    
}
