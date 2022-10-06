//
//  ProfileViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import Firebase
import RxSwift
import RxCocoa
import Combine

class SettingsViewModel {
    
    var onTableRefresh = {}
    let disposeBag = DisposeBag()
    var user: ApplicationUser?
    
    func configure() {
        AuthManager.shared.currentUser
            .subscribe { [weak self] user in
                print("User is: \(user)")
                self?.user = user
                self?.onTableRefresh()
            } onError: { error in
                print(error)
            } onCompleted: {
                print("user completed")
            } onDisposed: {
                print("disposed")
            }.disposed(by: disposeBag)
    }
    
}
