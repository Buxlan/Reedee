//
//  SignInViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import RxSwift
import RxRelay
import Firebase

class SignInViewModel {
    
    weak var delegate: Alertable?
    
    var disposeBag = DisposeBag()

    var loginBehaviorRelay = BehaviorRelay<String>(value: "")
    var passwordBehaviorRelay = BehaviorRelay<String>(value: "")
    
    init() {
        _ = loginBehaviorRelay.subscribe { value in
            print("next: \(value)")
        } onError: { error in
            print("error: \(error)")
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }.disposed(by: disposeBag)

    }
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(loginBehaviorRelay, passwordBehaviorRelay)
            .map { userName, password in
                return userName.count > 3
                        && userName.count < 20
                        && password.count > 3
                        && password.count < 25
            }
    }
    
    func loginWithEmail(completion: @escaping CompletionBlock) {
        AuthManager.shared.signIn(with: loginBehaviorRelay.value,
                                  password: passwordBehaviorRelay.value) { [weak self] errorStr in
            if let errorStr = errorStr {
                self?.delegate?.showAlert(title: "Login error", message: errorStr,
                                          type: .ok,
                                          completion: nil)
            }
            completion()
        }
    }
        
}
