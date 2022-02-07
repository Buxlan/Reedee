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
    
    private lazy var inputTextTransactionsViewController: AppendTransactionsViewController = {
        let vc = AppendTransactionsViewController(type: self.type)
        vc.onNext = { [weak self] in
            guard let self = self,
                  self.viewModel.isTextValid(vc.text) else {
                return
            }
            log.debug("inputTextTransactionsViewController onNext: \(vc.text)")
            var values = self.viewModel.parseText(vc.text)
            values = values.map { value in
                var transaction = value
                transaction.amount = value.amount.isZero ? vc.amount : transaction.amount
                return transaction
            }
            let viewModel = TransactionsConfirmViewModel(transactions: values)
            self.transactionsConfirmViewController.viewModel = viewModel
            self.pageViewController.setViewControllers([self.transactionsConfirmViewController],
                                                       direction: .forward,
                                                       animated: true,
                                                       completion: nil)
        }
        return vc
    }()
    
    private lazy var transactionsConfirmViewController: TransactionsConfirmViewController = {
        let viewModel = TransactionsConfirmViewModel()
        let vc = TransactionsConfirmViewController(type: self.type, viewModel: viewModel)
        vc.onNext = { [weak self] in
            guard !vc.viewModel.sections.isEmpty else {
                return
            }
            let uploader = FinanceTransactionUploader()
            uploader.uploadTransactions(vc.viewModel.sections[0].transactions) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
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
