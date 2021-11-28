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
    
    private var observers: [WeakUserObserver] = []
    private lazy var authStateListener: (Auth, User?) -> Void = { [weak self] (_, user) in
        guard let self = self,
              let user = user else {
            return
        }
        print("Succesfully signed, user ID is: \(user.uid)")
        self.current = AuthFactory().makeApplicationUser(firebaseUser: user) {
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
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            guard let user = authResult?.user else {
                return
            }
            print("Succesfully signed, user ID is: \(user.uid)")
            Auth.auth().addStateDidChangeListener(self.authStateListener)
            self.current = AuthFactory().makeApplicationUser(firebaseUser: user) {
                guard let user = self.current else {
                    return
                }
                self.observers.forEach { weakObserver in
                    weakObserver.value?.didChangeUser(user)
                }
            }
            
        }
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
