//
//  GroupMemberProxy.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.03.2022.
//

class GroupMemberProxy: GroupMember {
    
    var object: GroupMemberImpl?
    
    var objectIdentifier: String {
        get { object?.objectIdentifier ?? "" }
        set { object?.objectIdentifier = newValue }
    }
    var name: String {
        get { object?.name ?? "" }
        set { object?.name = newValue }
    }
    var surname: String {
        get { object?.surname ?? "" }
        set { object?.surname = newValue }
    }
    var number: String {
        get { object?.number ?? "" }
        set { object?.number = newValue }
    }
    var parentUserId: String {
        get { object?.parentUserId ?? "" }
        set { object?.parentUserId = newValue }
    }
    
    func encode() -> [String: Any] {
        guard let object = object else {
            return [:]
        }
        return object.encode()

    }
    
}

