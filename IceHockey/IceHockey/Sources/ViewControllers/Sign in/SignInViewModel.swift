//
//  SignInViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import RxSwift
import RxRelay

class SignInViewModel {
    
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
                return userName.count > 3 && password.count > 3
            }
    }
        
}
