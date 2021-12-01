//
//  AuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import Firebase

struct WeakUserObserver {
    weak var value: UserObserver?
}

protocol UserObserver: AnyObject {
    func didChangeUser(_ user: ApplicationUser)
}

class AuthManager {
    
    // MARK: - Properties
    
    static let shared = AuthManager()
    var current: ApplicationUser?
    var userCreator: ApplicationUserCreator?
    
    private var observers: [WeakUserObserver] = []
    lazy var authStateListener: (Auth, User?) -> Void = { [weak self] (_, user) in
        guard let self = self,
              let user = user else {
            return
        }
        print("Succesfully signed, user ID is: \(user.uid)")
        let creator = ApplicationUserCreator()
        self.userCreator = creator
        self.current = creator.create(firebaseUser: user) {
            self.observers.forEach { weakObserver in
                guard let user = self.current else {
                    return
                }
                weakObserver.value?.didChangeUser(user)
            }
        }
    }
    
    // MARK: - Lifrecircle
    
    private init() {
    }
    
    // MARK: - Hepler methods
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously()
    }
    
    func addObserver(_ observer: UserObserver) {
        let weakObserver = WeakUserObserver(value: observer)
        observers.append(weakObserver)
    }
    
    func removeObserver(_ observer: UserObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
    }
    
}
