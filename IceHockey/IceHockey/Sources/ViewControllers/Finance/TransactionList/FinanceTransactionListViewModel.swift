//
//  FinanceTransactionListViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import Firebase

class FinanceTransactionListViewModel {
    
    // MARK: - Properties
    
    struct SectionData {
        var title: String = ""
        var transactions: [FinanceTransaction] = []
    }
    var sections: [SectionData] = []
    private var authManager: AuthManager = FirebaseAuthManager.shared
    lazy var user: ApplicationUser? = authManager.current
    
    var shouldTableRefresh = {}
    var setRightsEventAddition: (UserRoleManager.Role) -> Void = { _ in }
    
    private var loader = FinanceTransactionListLoader()
    var isLoading: Bool {
        return loader.isLoading
    }
    
    // MARK: - Actions
    
    private var isAuthCompleted: Bool {
        return user != nil
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
        guard isAuthCompleted else {
            return
        }
        loader.flush()
        let eventListCompletionHandler: ([FinanceTransaction]) -> Void = { [weak self] objects in
            guard let self = self,
                  objects.count > 0 else {
                return
            }
            var section = SectionData()
            section.transactions.append(contentsOf: objects)
            self.sections = [section]
            self.shouldTableRefresh()
        }
        let eventLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefresh()
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
    func nextUpdate() {
        guard isAuthCompleted else {
            return
        }
        print("updateNextPortion")
        let eventListCompletionHandler: ([FinanceTransaction]) -> Void = { [weak self] objects in
            guard let self = self else { return }
            assert(self.sections.count > 0)
            self.sections[0].transactions.append(contentsOf: objects)
            self.shouldTableRefresh()
        }
        let eventLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefresh()
        }
        loader.load(eventListCompletionHandler: eventListCompletionHandler,
                    eventLoadedCompletionHandler: eventLoadedCompletionHandler)
    }
    
    func getBalance(number: String) -> Double {
        guard !sections.isEmpty else {
            return 0.0
        }
        let filtered = sections[0].transactions.filter {
            $0.number == number
        }
        return filtered.reduce(0.0) { partialResult, transaction in
            let value = (transaction.type == .income ? 1 : -1) * transaction.amount
            return partialResult + value
        }
    }
    
}

extension FinanceTransactionListViewModel: UserObserver {
    func didChangeUser(_ user: ApplicationUser) {
        log.debug("HomeViewModel didChangeUser: user: \(user)")
        self.user = user
        UserRoleManager().getRole(for: user) { [weak self] role in
            self?.setRightsEventAddition(role)
        }
        update()
    }
}
