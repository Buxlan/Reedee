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
    
    private var uploads: [String: FinanceTransactionUploader] = [:]
    
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
        let objectListCompletionHandler: ([FinanceTransaction]) -> Void = { [weak self] objects in
            guard let self = self,
                  objects.count > 0 else {
                return
            }
            var section = SectionData()
            section.transactions.append(contentsOf: objects)
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
        let objectListCompletionHandler: ([FinanceTransaction]) -> Void = { [weak self] objects in
            guard let self = self else { return }
            assert(self.sections.count > 0)
            self.sections[0].transactions.append(contentsOf: objects)
            self.shouldTableRefresh()
        }
        let objectLoadedCompletionHandler: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.shouldTableRefresh()
        }
        loader.load(objectListCompletionHandler: objectListCompletionHandler,
                    objectLoadedCompletionHandler: objectLoadedCompletionHandler)
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
    
    func switchActivity(of transaction: FinanceTransaction,
                        with completionHandler: @escaping (Result<Int,
                                                      FirebaseDataError>) -> Void) {
        var editedTransaction = transaction
        editedTransaction.isActive.toggle()
        let uploader = FinanceTransactionUploader()
        uploads[transaction.objectIdentifier] = uploader
        uploader.uploadTransaction(editedTransaction) { [weak self] in
            guard let self = self,
                  !self.sections.isEmpty,
                  let index = self.sections[0].transactions.firstIndex(where: {
                      $0.objectIdentifier == editedTransaction.objectIdentifier
                    }) else {
                        completionHandler(.failure(.common))
                        return
                    }
            
            self.sections[0].transactions[index] = editedTransaction
            self.shouldTableRefresh()
            completionHandler(.success(200))
            
        }
    }
    
}

extension DocumentListViewModel: UserObserver {
    func didChangeUser(_ user: ApplicationUser) {
        log.debug("HomeViewModel didChangeUser: user: \(user)")
        self.user = user
        UserRoleManager().getRole(for: user) { [weak self] role in
            self?.setRightsEventAddition(role)
        }
        update()
    }
}
