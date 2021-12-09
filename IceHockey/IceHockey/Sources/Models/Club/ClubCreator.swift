//
//  ClubCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 12/2/21.
//

import Firebase
import RxSwift
import RxCocoa

class ClubCreator {
    
    private var builder: ClubBuilder?
    
    func create(objectIdentifier: String,
                completed completionHandler: @escaping () -> Void)
    -> Club {
        let builder = ClubBuilder(objectIdentifier: objectIdentifier)
        self.builder = builder
        builder.build { [weak self] in
            completionHandler()
            self?.builder = nil
        }
        let object = builder.getResult()
        return object
    }
    
}
