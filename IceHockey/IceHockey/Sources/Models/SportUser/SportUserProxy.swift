//
//  SportUserProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 11/24/21.
//

import UIKit

class SportUserProxy: SportUser {
    
    var user: SportUserImpl? {
        didSet {
            loadingCompletionHandler()
            loadingCompletionHandler = {}
        }
    }
    var loadingCompletionHandler: () -> Void = {}
    
    var objectIdentifier: String {
        get { user?.objectIdentifier ?? "" }
        set { user?.objectIdentifier = newValue }
    }
    var displayName: String {
        get { user?.displayName ?? "" }
        set { user?.displayName = newValue }
    }
    var imageID: String {
        get { user?.imageID ?? "" }
        set { user?.imageID = newValue }
    }
    var image: UIImage? {
        get { user?.image }
        set { user?.image = newValue }
    }
    
}
