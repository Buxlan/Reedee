//
//  AppendTransactionsStepByStepViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import SnapKit

class AppendTransactionsStepByStepViewController: UIViewController {
    
    // MARK: - Properties
    
    private var type: TransactionType
    private lazy var viewModel = AppendTransactionsStepByStepViewModel(type: self.type)
    private var uploader: OperationDocumentFirebaseSaver?
    
    private lazy var inputTextTransactionsViewController: PrepareTransactionsFromTextViewController = {
        let vc = PrepareTransactionsFromTextViewController(type: self.type)
        vc.onNext = { [weak self] in
            guard let self = self,
                  self.viewModel.isTextValid(vc.text) else {
                return
            }
            log.debug("inputTextTransactionsViewController onNext: \(vc.text)")
            var transactions = self.viewModel.parseText(vc.text)
            var isCommonAmount = vc.isCommonAmount
            
            var amount: Double = vc.amount
            if isCommonAmount {
                var nilAmountTransactions = transactions.filter {
                    $0.amount == 0.0
                }
                var allocatedAmount = transactions.reduce(0) { partialResult, transaction in
                    return partialResult + transaction.amount
                }
                let notNilTransactionCount = transactions.count - nilAmountTransactions.count
                log.debug("inputTextTransactionsViewController: notNilTransactionCount = \(notNilTransactionCount)")
                let notAllocatedAmount = vc.amount - allocatedAmount
                log.debug("inputTextTransactionsViewController: notAllocatedAmount = \(notAllocatedAmount)")
                if nilAmountTransactions.isEmpty {
                    amount = notAllocatedAmount
                } else {
                    amount = (notAllocatedAmount / Double(nilAmountTransactions.count))
                                .round(to: 2, using: .down)
                }
                log.debug("inputTextTransactionsViewController: amount = \(amount)")
            }
            
            transactions = transactions.map { value in
                var transaction = value
                transaction.amount = value.amount.isZero ? amount : value.amount
                transaction.comment = value.comment.isEmpty ? vc.comment : value.comment
                return transaction
            }
            log.debug("inputTextTransactionsViewController: transactions.count = \(transactions.count)")
            let viewModel = TransactionsConfirmViewModel(transactions: transactions)
            self.transactionsConfirmViewController.viewModel = viewModel
            self.pageViewController.setViewControllers([self.transactionsConfirmViewController],
                                                       direction: .forward,
                                                       animated: true) { _ in
                viewModel.update()
            }
        }
        return vc
    }()
    
    private lazy var transactionsConfirmViewController: TransactionsConfirmViewController = {
        let viewModel = TransactionsConfirmViewModel()
        let vc = TransactionsConfirmViewController(type: self.type, viewModel: viewModel)
        vc.onNext = { [weak self, vc] in
            guard let self = self,
                !vc.viewModel.sections.isEmpty else {
                return
            }
            let transactions = vc.viewModel.sections[0].transactions,
                creator = DocumentCreator(),
                document = creator.createOperationDocument(with: transactions),
                saver = OperationDocumentFirebaseSaver(object: document)
            
            self.uploader = saver
            saver.save { [weak self] error in
                if error != nil {
                    log.debug("AppendTransactionsStepByStepViewController saving document error ")
                }
                self?.uploader = nil
                self?.navigationController?.popViewController(animated: false)
                let vc = OperationDocumentDetailViewController()
                vc.document = document
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        vc.onBack = { [weak self] in
            guard let self = self else { return }
            self.pageViewController
                .setViewControllers([self.inputTextTransactionsViewController],
                                    direction: .reverse,
                                    animated: true)
        }
        return vc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController()
        vc.setViewControllers([inputTextTransactionsViewController],
                                direction: .forward,
                                animated: false)
        return vc
    }()
    
    // MARK: - Lifecircle
    
    init(type: TransactionType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = type == .income ? L10n.Finance.Transactions.income : L10n.Finance.Transactions.costs
        view.backgroundColor = Colors.Gray.light
        
        view.addSubview(pageViewController.view)
        
        addChild(pageViewController)
        didMove(toParent: pageViewController)
        
        configureConstraints()
    }
    
    // MARK: - Helpers
    
    private func configureConstraints() {
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
    }
    
}
