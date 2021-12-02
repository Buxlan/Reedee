//
//  SquadCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 12/2/21.
//

import Firebase

class SquadCreator {
    
    private var builder: SquadBuilder?
    
    func create(objectIdentifier: String,
                completed completionHandler: @escaping () -> Void)
    -> Squad {        
        let builder = SquadBuilder(objectIdentifier: objectIdentifier)
        self.builder = builder
        builder.build { [weak self] in
            completionHandler()
            self?.builder = nil
        }
        let object = builder.getResult()
        return object
    }
    
}
