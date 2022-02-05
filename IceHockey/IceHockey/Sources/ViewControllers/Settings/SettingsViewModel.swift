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

enum Setting: CustomStringConvertible {
    case profileInfo
    case signIn
    case signUp
    case logout
    case newEvent
    case newMatchResult
    
    var description: String {
        switch self {
        case .profileInfo:
            return L10n.Profile.title
        case .signIn:
            return L10n.Profile.signIn
        case .logout:
            return L10n.Profile.logout
        case .signUp:
            return L10n.Profile.signUp
        case .newEvent:
            return L10n.Events.appendNew
        case .newMatchResult:
            return L10n.MatchResult.appendNew
        }
    }
    
    var hasDisclosure: Bool {
        switch self {
        case .newEvent, .signUp, .signIn, .newMatchResult:
            return true
        default:
            return false
        }
    }
    
}

class SettingsViewModel {
    
    var onTableRefresh = {}
    let disposeBag = DisposeBag()
    var user: ApplicationUser?
    
    func configure() {
        FirebaseAuthManager.shared.currentUser
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
