//
//  ClubManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation
import RxSwift
import RxCocoa

struct WeakClubObserver {
    weak var value: ClubObserver?
}

protocol ClubObserver: AnyObject {
    func didChangeTeam(_ club: Club)
}

class ClubManager {
    
    static let shared = ClubManager()
    var current: Club
    private var observers: [WeakClubObserver] = []
    var clubCreator: ClubCreator?
    
    private let authManager: AuthManagerProtocol = AuthManager.shared
    private let disposeBag = DisposeBag()

    private init() {
        current = EmptyClub()
        _ = authManager.currentUser.subscribe { [weak self] _ in
            self?.prepareCurrentClub()
        }.disposed(by: disposeBag)
    }
    
    private func prepareCurrentClub() {
        guard let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String
        else {
            return
        }
        let creator = ClubCreator()
        self.clubCreator = creator
        current = creator.create(objectIdentifier: teamID) { [weak self] in
            guard let self = self else { return }
            for weakObserver in self.observers {
                weakObserver.value?.didChangeTeam(self.current)
            }
            self.clubCreator = nil
        }
    }
    
    func addObserver(_ observer: ClubObserver) {
        let weakObserver = WeakClubObserver(value: observer)
        observers.append(weakObserver)
    }
    
    func removeObserver(_ observer: ClubObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
    }
    
}
