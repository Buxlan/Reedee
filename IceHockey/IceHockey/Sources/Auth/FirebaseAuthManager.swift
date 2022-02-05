//
//  FirebaseAuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 12/4/21.
//

import Firebase
import RxSwift
import RxRelay

class FirebaseAuthManager: AuthManager {
    
    // MARK: - Properties
    
    static let shared: AuthManager = FirebaseAuthManager()
    var current: ApplicationUser?
        
    var currentUser: PublishRelay<ApplicationUser> = PublishRelay()
    
    private var userCreator: ApplicationUserCreator?    
    private var observers: [WeakUserObserver] = []
    
    lazy var authStateListener: (Auth, User?) -> Void = { [weak self] (_, user) in
        guard let self = self,
              let user = user else {
            return
        }
        print("Succesfully signed, user ID is: \(user.uid)")
        let creator = ApplicationUserCreator()
        self.userCreator = creator
        self.current = creator.create(firebaseUser: user) { [weak self] in
            guard let self = self else { return }
            for weakObserver in self.observers {
                guard let user = self.current else {
                    return
                }
                weakObserver.value?.didChangeUser(user)
                self.currentUser.accept(user)
                self.save()
            }
            self.userCreator = nil
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

extension FirebaseAuthManager {
    
    func save() {
        log.debug("FirebaseAuthManager save")
        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: current as Any, requiringSecureCoding: false)
        AppState.currentUser.modify(encodedData)
    }
    
    func restore() -> ApplicationUser? {
        log.debug("FirebaseAuthManager restore")
        guard let data = AppState.currentUser.value,
              let unwrapped = data,
              let object = try? NSKeyedUnarchiver
                .unarchiveTopLevelObjectWithData(unwrapped) as? ApplicationUser
        else {
            return nil
        }
        
        return object
    }
    
}
