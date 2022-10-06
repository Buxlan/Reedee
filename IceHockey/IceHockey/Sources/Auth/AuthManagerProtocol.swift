//
//  AuthManagerProtocol.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import Firebase
import RxCocoa
import RxSwift

protocol SaveStateProtocol {
    func save()
}

protocol RestoreStateProtocol {
    func restore() -> ApplicationUser?
}

protocol AuthManagerProtocol: SaveStateProtocol, RestoreStateProtocol {
    static var shared: AuthManagerProtocol { get }
    var current: ApplicationUser? { get set }
    var currentUser: PublishRelay<ApplicationUser> { get }
    var authStateListener: (Auth, User?) -> Void { get }
    
    func signIn(coordinator: Coordinatable)
    func signInAnonymously()
    func signIn(with email: String, password: String,
                completion: @escaping (String?) -> Void)
    func addObserver(_ observer: UserObserver)
    func removeObserver(_ observer: UserObserver)
}

struct WeakUserObserver {
    weak var value: UserObserver?
}

protocol UserObserver: AnyObject {
    func didChangeUser(_ user: ApplicationUser)
}
