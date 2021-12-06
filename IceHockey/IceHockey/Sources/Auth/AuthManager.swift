//
//  AuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import Firebase
import RxCocoa
import RxSwift

protocol AuthManager {
    static var shared: AuthManager { get }
    var current: ApplicationUser? { get set }
    var currentUser: PublishRelay<ApplicationUser> { get }
    func signInAnonymously()
    var authStateListener: (Auth, User?) -> Void { get }
    func addObserver(_ observer: UserObserver)
    func removeObserver(_ observer: UserObserver)
}

struct WeakUserObserver {
    weak var value: UserObserver?
}

protocol UserObserver: AnyObject {
    func didChangeUser(_ user: ApplicationUser)
}
