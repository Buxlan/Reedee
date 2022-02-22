//
//  MatchResultEditViewModel.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/29/21.
//

import UIKit

class MatchResultEditViewModel {
    
    // MARK: - Propetries
    
    var event: MatchResult
    var shouldReloadRelay = {}
    var collectionViewDataSource = CollectionDataSource()
    var wasEdited: Bool = false
    
    private var loadingHandlers: [String: (UIImage?) -> Void] = [:]
    
    init(event: MatchResult) {
        self.event = event
    }
    
    deinit {
        print("!!!! deinit!")
    }
    
}

extension MatchResultEditViewModel {
    
    // MARK: - Helper methods
        
    func save(completionHandler: @escaping (SaveObjectError?) -> Void) {
        event.save(completionHandler: completionHandler)
    }
    
    func delete(completionHandler: @escaping (FirebaseRemoveError?) -> Void) {
        event.delete(completionHandler: completionHandler)
    }
    
}
