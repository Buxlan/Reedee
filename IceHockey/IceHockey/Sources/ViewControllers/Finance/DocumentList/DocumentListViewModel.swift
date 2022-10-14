//
//  DocumentListViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Firebase

class DocumentListViewModel {
    
    // MARK: - Properties
    
    struct SectionData {
        var title: String = ""
        var documents: [Document] = []
    }
    var sections: [SectionData] = []
    private var authManager: AuthManagerProtocol = AuthManager.shared
    
    var shouldTableRefresh = {}
    var setRightsEventAddition: (UserRoleManager.Role) -> Void = { _ in }
    
    private var loader = DocumentListLoader()
    var isLoading: Bool {
        return loader.isLoading
    }
    
    // MARK: - Actions
    
    private var isAuthCompleted: Bool {
        return authManager.current != nil
    }
    
    // MARK: Lifecircle
    
    init() {
        authManager.addObserver(self)
    }
    
    deinit {
        authManager.removeObserver(self)
    }
            
    // MARK: - Hepler functions
        
    func update() {
        guard isAuthCompleted,
              !isLoading else {
            return
        }
        loader.flush()
        let objectListCompletionHandler: ([Document]) -> Void = { [weak self] objects in
            guard let self = self,
                  objects.count > 0 else {
                return
            }
            var section = SectionData()
            section.documents.append(contentsOf: objects)
            self.sections = [section]
            self.shouldTableRefresh()
        }
        let objectLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefresh()
        }
        loader.load(objectListCompletionHandler: objectListCompletionHandler,
                    objectLoadedCompletionHandler: objectLoadedCompletionHandler)
    }
    
    func nextUpdate() {
        guard isAuthCompleted else {
            return
        }
        print("updateNextPortion")
        let objectListCompletionHandler: ([Document]) -> Void = { [weak self] objects in
            guard let self = self else { return }
            assert(self.sections.count > 0)
            self.sections[0].documents.append(contentsOf: objects)
            self.shouldTableRefresh()
        }
        let objectLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefresh()
        }
        loader.load(objectListCompletionHandler: objectListCompletionHandler,
                    objectLoadedCompletionHandler: objectLoadedCompletionHandler)
    }
    
}

extension DocumentListViewModel: AuthObserver {
    func didChangeUser(_ user: ApplicationUser) {
        log.debug("HomeViewModel didChangeUser: user: \(user)")
        UserRoleManager().getRole(for: user) { [weak self] role in
            self?.setRightsEventAddition(role)
        }
        update()
    }
}
