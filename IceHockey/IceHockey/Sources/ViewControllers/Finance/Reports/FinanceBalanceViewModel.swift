//
//  FinanceBalanceViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import Firebase

class FinanceBalanceViewModel {
    
    // MARK: - Properties
    
    struct SectionData {
        var title: String = ""
        var transactions: [FinanceTransactionProtocol] = []
    }
    var sections: [SectionData] = []
    lazy var user: ApplicationUser? = authManager.current
    
    var shouldTableRefresh = {}
    var setRightsEventAddition: (UserRoleManager.Role) -> Void = { _ in }
    
    var isLoading: Bool {
        return loader.isLoading
    }
    private var isAuthCompleted: Bool {
        return user != nil
    }
    
    private var loader = FinanceTransactionListLoader()
    private var authManager: AuthManagerProtocol = AuthManager.shared
    private var allTransactions: [FinanceTransaction] = []
 
    // MARK: Lifecircle
    
    init() {
        authManager.addObserver(self)
    }
    
    deinit {
        authManager.removeObserver(self)
    }
            
    // MARK: - Hepler
        
    func update() {
        guard isAuthCompleted else {
            return
        }
        loader.flush()
        let objectListCompletionHandler: ([FinanceTransaction]) -> Void = { [weak self] objects in
            guard let self = self,
                  objects.count > 0 else {
                return
            }
            self.allTransactions = objects
            let balance = self.getPlayersBalance()
            var section = SectionData()
            section.transactions = balance
            self.sections = [section]
            self.shouldTableRefresh()
        }
        let objectLoadedCompletionHandler: () -> Void = {}
        loader.load(objectListCompletionHandler: objectListCompletionHandler,
                    objectLoadedCompletionHandler: objectLoadedCompletionHandler)
    }
    
    func getPlayersBalance() -> [FinanceTransactionProtocol] {
        guard !allTransactions.isEmpty else {
            return []
        }
        var summaryBalance: [FinanceTransactionProtocol] = []
        allTransactions.forEach { transaction in
            if !transaction.isActive { return }
            if summaryBalance.contains(where: {
                $0.number == transaction.number
            }) {
                return
            }
            var balanceTransaction = transaction.clone()
            balanceTransaction.amount = getBalanceByPlayer(number: transaction.number)
            balanceTransaction.type = balanceTransaction.amount >= 0.0 ? .income : .cost
            if balanceTransaction.amount != 0 {
                summaryBalance.append(balanceTransaction)
            }
        }
        summaryBalance.sort { $0.name < $1.name }
        return summaryBalance
    }
    
    func getBalanceByPlayer(number: String) -> Double {
        guard !allTransactions.isEmpty else {
            return 0.0
        }
        let filtered = allTransactions.filter {
            $0.isActive && $0.number == number 
        }
        var balance = filtered.reduce(0.0) { partialResult, transaction in
            let value = (transaction.type == .income ? 1 : -1) * transaction.amount
            return partialResult + value
        }
        balance = balance.round(to: 2, using: .down)
        return balance
    }
    
    func exportBalance() -> String {
        guard !sections.isEmpty else {
            return ""
        }
        
        var textBalance = ""
        let filtered = sections[0].transactions.filter { $0.isActive }
        let sorted = filtered.sorted { $0.name < $1.name }
        var summary: Double = 0.0
        
        for (index, transaction) in sorted.enumerated() {
            let amount = transaction.amount.rounded(.down)
            summary += amount
            let str = "\(index+1)\t\(transaction.name)   \(transaction.number)   \(amount)р."
            textBalance += (textBalance.isEmpty ? "" : "\n") + str
        }
        textBalance += (textBalance.isEmpty ? "" : "\n\n") + "Summary" + ": \(summary)"
        return textBalance
    }
    
}

extension FinanceBalanceViewModel: UserObserver {
    
    func didChangeUser(_ user: ApplicationUser) {
        log.debug("HomeViewModel didChangeUser: user: \(user)")
        self.user = user
        UserRoleManager().getRole(for: user) { [weak self] role in
            self?.setRightsEventAddition(role)
        }
        update()
    }
    
}
