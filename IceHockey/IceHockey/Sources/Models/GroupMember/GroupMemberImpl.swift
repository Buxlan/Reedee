//
//  GroupMemberImpl.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.03.2022.
//

struct GroupMemberImpl: GroupMember {
        
    // MARK: - Properties
    
    var objectIdentifier: String
    var name: String
    var surname: String
    var number: String
    var parentUserId: String
    
    // MARK: - Lifecircle
        
    init(databaseData: GroupMemberDatabaseFlowData) {
        self.objectIdentifier = databaseData.objectIdentifier
        self.name = databaseData.name
        self.surname = databaseData.surname
        self.parentUserId = databaseData.parentUserId
        self.number = databaseData.number
    }
    
    // MARK: - Helper methods
    
    func encode() -> [String: Any] {
        let dict: [String: Any] = [
            "uid": objectIdentifier,
            "name": name,
            "surname": surname,
            "number": number,
            "parentUserId": parentUserId
        ]
        return dict
    }
    
}
