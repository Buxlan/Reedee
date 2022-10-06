//
//  TransactionsConfirmViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

class TransactionsConfirmViewModel {
    
    struct SectionData {
        var title: String = ""
        var transactions: [FinanceTransaction] = []
    }
    var sections: [SectionData]
    
    // MARK: - Lifecircle
    
    init() {
        sections = []
        authManager.addObserver(self)
    }
    
    init(transactions: [FinanceTransaction]) {
        var section = SectionData()
        section.transactions.append(contentsOf: transactions)
        self.sections = [section]
        authManager.addObserver(self)
    }
    
    deinit {
        authManager.removeObserver(self)
    }
    
    private var authManager: AuthManagerProtocol = AuthManager.shared
    lazy var user: ApplicationUser? = authManager.current
    
    var shouldTableRefresh = {}
    
    private var isAuthCompleted: Bool {
        return user != nil
    }
    
    // MARK: - Helpers
        
    func save() {
        
    }
    
    func update() {
        shouldTableRefresh()
    }
    
}

extension TransactionsConfirmViewModel: UserObserver {
    func didChangeUser(_ user: ApplicationUser) {
        log.debug("HomeViewModel didChangeUser: user: \(user)")
        self.user = user
        UserRoleManager().getRole(for: user) { [weak self] role in
//            self?.setRightsEventAddition(role)
        }
//        update()
    }
}
