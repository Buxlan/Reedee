//
//  FirebaseObjectBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 12/1/21.
//

protocol FirebaseObjectBuilder {
    init(objectIdentifier: String)
    func build(completionHandler: @escaping () -> Void)
}
