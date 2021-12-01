//
//  ApplicationUserCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/30/21.
//

import Firebase

class ApplicationUserCreator {
    
    private var builder: SportUserBuilder?
    
    func create(firebaseUser: User,
                completed completionHandler: @escaping () -> Void)
    -> ApplicationUser {
        
        let objectIdentifier = firebaseUser.uid
        let builder = SportUserBuilder(objectIdentifier: objectIdentifier)
        self.builder = builder
        builder.build { [weak self] in
            completionHandler()
            self?.builder = nil
        }
        let sportUser = builder.getResult()
        let applicationUser = ApplicationUser(firebaseUser: firebaseUser,
                                              sportUser: sportUser)
        return applicationUser
    }
    
}
