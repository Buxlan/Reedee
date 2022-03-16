//
//  GroupMember.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.03.2022.
//

protocol GroupMember: FirebaseObject {
    var objectIdentifier: String { get set }
    var name: String { get set }
    var surname: String { get set }
    var number: String { get set }
    var parentUserId: String { get set }
}
