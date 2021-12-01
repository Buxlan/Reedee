//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase

class HomeViewModel {
    
    // MARK: - Properties
    
    struct SectionData {
        var title: String = ""
        var events: [SportEvent] = []
    }
    var sections: [SectionData] = []
    var dataSource = TableDataSource()
    var club: Club = ClubManager.shared.current
    var user: ApplicationUser? = AuthManager.shared.current
    
    var shouldTableRefreshRelay = {}
    var shouldClubRefreshRelay = {}
    var setRightsEventAdditionRelay: (UserRoleManager.Role) -> Void = { _ in }
    
    private var loader = SportEventListLoader()
    var isLoading: Bool {
        return loader.isLoading
    }
    
    // MARK: - Actions
    
    var actions: [ActionCollectionCellConfigurator] = [
        ActionCollectionCellConfigurator(data: QuickAction.joinClub),
        ActionCollectionCellConfigurator(data: QuickAction.contacts),
        ActionCollectionCellConfigurator(data: QuickAction.showTrainingSchedule),
        ActionCollectionCellConfigurator(data: QuickAction.showOnMap)
    ]
    
    private var isAuthCompleted: Bool {
        return user != nil
    }
    
    // MARK: Lifecircle
    
    init() {
        AuthManager.shared.addObserver(self)
        ClubManager.shared.addObserver(self)
    }
    
    deinit {
        print("deinit HWM")
        AuthManager.shared.removeObserver(self)
        ClubManager.shared.removeObserver(self)
    }
            
    // MARK: - Hepler functions     
    
    func action(at indexPath: IndexPath) -> ActionCollectionCellConfigurator {
        actions[indexPath.item]
    }
        
    func update() {
        guard isAuthCompleted else {
            return
        }
        loader.flush()
        let eventListCompletionHandler: ([SportEvent]) -> Void = { [weak self] events in
            guard let self = self else { return }
            guard events.count > 0 else {
                return
            }
            var section = SectionData()
            section.events.append(contentsOf: events)
            self.sections = [section]
            self.shouldTableRefreshRelay()
        }
        let eventLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefreshRelay()
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
    func updateNextPortion() {
        guard isAuthCompleted else {
            return
        }
        print("updateNextPortion")
        let eventListCompletionHandler: ([SportEvent]) -> Void = { [weak self] events in
            guard let self = self else { return }
            assert(self.sections.count > 0)
            self.sections[0].events.append(contentsOf: events)
            self.shouldTableRefreshRelay()
        }
        let eventLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefreshRelay()
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
}

extension HomeViewModel: UserObserver {
    func didChangeUser(_ user: ApplicationUser) {
        self.user = user
        UserRoleManager().getRole(for: user) { [weak self] role in
            self?.setRightsEventAdditionRelay(role)
        }
        update()
    }
}

extension HomeViewModel: ClubObserver {
    
    func didChangeTeam(_ club: Club) {
        self.club = club
        shouldClubRefreshRelay()
    }
    
}
