//
//  ProfileViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 27.03.2022.
//

import Firebase
import RxSwift
import RxCocoa

class ProfileViewModel {
    
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
