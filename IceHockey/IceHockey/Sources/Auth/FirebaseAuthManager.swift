//
//  FirebaseAuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 12/4/21.
//

import Firebase
import RxSwift
import RxRelay

class FirebaseAuthManager: AuthManagerProtocol {
    
    // MARK: - Properties
    
    static let shared: AuthManagerProtocol = FirebaseAuthManager()
    var current: ApplicationUser?
        
    var currentUser: PublishRelay<ApplicationUser> = PublishRelay()
    
    private var userCreator: ApplicationUserCreator?    
    private var observers: [WeakUserObserver] = []
    
    lazy var authStateListener: (Auth, User?) -> Void = { [unowned self] (_, user) in
        guard let user = user else {
            // login anonymously
            Auth.auth().signInAnonymously { [unowned self] authResult, error in
                if let error = error {
                    NotificationCenter.default.post(name: NotificationName.networkUnavailable.value, object: nil)
                    Session.isAuthorized = false
                    return
                }
                guard let authResult = authResult else {
                    NotificationCenter.default.post(name: NotificationName.signInFailed.value, object: nil)
                    Session.isAuthorized = false
                    return
                }
                Session.isAuthorized = true
                self.prepare(with: authResult.user)
            }
            return
        }
            
        print("Succesfully signed, user ID is: \(user.uid)")
        Session.isAuthorized = true
        TokenUtil.setToken(.refreshToken, user.refreshToken)
        user.getIDToken { token, error in
            if let error = error {
                print("FirebaseAuthManager getIDToken error: \(error.localizedDescription)")
                return
            }
            guard let token = token else {
                return
            }
            TokenUtil.setToken(.accessToken, token)
        }
        self.prepare(with: user)
    }
    
    // MARK: - Lifrecircle
    
    private init() {
    }
    
    // MARK: - Hepler methods
    
    func addObserver(_ observer: AuthObserver) {
        let weakObserver = WeakUserObserver(value: observer)
        observers.append(weakObserver)
        if let user = self.current {
            observer.didChangeUser(user)
        }
    }
    
    func removeObserver(_ observer: AuthObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
    }
    
    private func prepare(with user: User) {
        let creator = ApplicationUserCreator()
        self.userCreator = creator
        self.current = creator.create(firebaseUser: user) { [weak self] in
            guard let self = self else { return }
            guard let user = self.current else { return }
            for weakObserver in self.observers {
                weakObserver.value?.didChangeUser(user)
                self.currentUser.accept(user)
                self.save()
            }
            self.userCreator = nil
        }
    }
    
}

// MARK: - Login methods
extension FirebaseAuthManager {
    
    func signIn(coordinator: Coordinatable) {
        if Session.isAuthorized,
           let token = UserDefaultsWrapper.token {
            signIn(using: token) { [weak coordinator] result in
                coordinator?.start()
            }
        } else {
            signInAnonymously()
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously()
    }
    
    func signIn(using token: String,
                completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withCustomToken: token) { authResult, error in
            
            if let error = error {
                log.debug("Sign in error: \(error.localizedDescription)")
                completion(error.localizedDescription)
                return
            }
            
            guard let authResult = authResult else {
                log.debug("Sign in authResult is nil")
                completion("Sign in authResult is nil")
                return
            }
            
            log.debug(authResult)
            
            authResult.user.getIDToken { token, error in
                if let error = error {
                    log.debug("Sign in error: \(error.localizedDescription)")
                    completion(error.localizedDescription)
                    return
                }
                
                guard let token = token else {
                    log.debug("Token is nil")
                    completion("Token is nil")
                    return
                }
                
                UserDefaultsWrapper.token = token
                completion(nil)
            }
            
        }
    }
    
    func signIn(with email: String, password: String,
                completion: @escaping (String?) -> Void) {
        
        Auth.auth().signIn(withEmail: email,
                           password: password) { authResult, error in
            
            if let error = error {
                log.debug("Sign in error: \(error.localizedDescription)")
                completion(error.localizedDescription)
                return
            }
            
            guard let authResult = authResult else {
                log.debug("Sign in authResult is nil")
                completion("Sign in authResult is nil")
                return
            }
            
            log.debug(authResult)
            
            authResult.user.getIDToken { token, error in
                if let error = error {
                    log.debug("Sign in error: \(error.localizedDescription)")
                    completion(error.localizedDescription)
                    return
                }
                
                guard let token = token else {
                    log.debug("Token is nil")
                    completion("Token is nil")
                    return
                }
                
                UserDefaultsWrapper.token = token
                completion(nil)
            }
            
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
