//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    
    struct SectionData {
        var title: String = ""
        var events: [SportEvent] = []
    }
    var sections: [SectionData] = []
    var dataSource = TableDataSource()
    var shouldRefreshRelay = {}
    var shouldRefreshAtIndexPathRelay: (IndexPath) -> Void = { _ in }
    var isLoading: Bool {
        return loader.isLoading
    }
    private var loader = SportEventListLoader()
    
    // MARK: - Actions
    
    var actions: [ActionCollectionCellConfigurator] = [
        ActionCollectionCellConfigurator(data: QuickAction.joinClub),
        ActionCollectionCellConfigurator(data: QuickAction.contacts),
        ActionCollectionCellConfigurator(data: QuickAction.showTrainingSchedule),
        ActionCollectionCellConfigurator(data: QuickAction.showOnMap)
    ]
    
    private var isAuthCompleted = false
    private lazy var authStateListener: (Auth, User?) -> Void = { [weak self] (_, _) in
        guard let self = self else {
            return
        }
        self.isAuthCompleted = true
        self.update()
    }
    
    // MARK: Lifecircle
    
    override init() {
        super.init()
        Auth.auth().addStateDidChangeListener(self.authStateListener)
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
        let eventListCompletionHandler: ([SportEvent]) -> Void = { events in
            guard events.count > 0 else {
                return
            }
            var section = SectionData()
            section.events.append(contentsOf: events)
            self.sections = [section]
            self.shouldRefreshRelay()
        }
        let eventLoadedCompletionHandler: (IndexPath) -> Void = { indexPath in
            self.shouldRefreshAtIndexPathRelay(indexPath)
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
    func updateNextPortion() {
        guard isAuthCompleted else {
            return
        }
        print("updateNextPortion")
        let eventListCompletionHandler: ([SportEvent]) -> Void = { events in
            assert(self.sections.count > 0)
            self.sections[0].events.append(contentsOf: events)
            self.shouldRefreshRelay()
        }
        let eventLoadedCompletionHandler: (IndexPath) -> Void = { indexPath in
            self.shouldRefreshAtIndexPathRelay(indexPath)
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
}
