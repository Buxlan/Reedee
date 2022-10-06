//
//  FinanceRouterViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.02.2022.
//

import SnapKit

class FinanceRouterViewController: UIViewController, FinanceViewProtocol {
    
    // MARK: - Properties
    
    var onCompletion: CompletionBlock?
    
    private lazy var transactionsButton: FinanceRouterButton = {
        let view = FinanceTransactionsButton()
        view.onSelect = { [weak self] in
            guard let self = self else {
                return
            }
            // navigate to measures and drugs
            self.navigateToTransactionsViewController()
        }
        
        return view
    }()
    
    private lazy var reportsButton: FinanceRouterButton = {
        let view = FinanceReportsButton()
        view.onSelect = { [weak self] in
            guard let self = self else {
                return
            }
            // navigate to my files
            self.navigateToReportsViewController()
        }
        
        return view
    }()
    
    private lazy var documentsButton: FinanceRouterButton = {
        let view = FinanceDocumentsButton()
        view.onSelect = { [weak self] in
            guard let self = self else {
                return
            }
            // navigate to my files
            self.navigateToDocumentsViewController()
        }
        
        return view
    }()
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.accent1.color
        return view
    }()
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.Gray.light
        
        view.addSubview(topBackgroundView)
        view.addSubview(transactionsButton)
        view.addSubview(reportsButton)
        view.addSubview(documentsButton)
        
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBars()
    }
    
}

// MARK: - Helpers

extension FinanceRouterViewController {
    
    private func configureConstraints() {
        
        topBackgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-4)
            make.width.equalToSuperview()
        }
        
        transactionsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        
        reportsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(transactionsButton.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        
        documentsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reportsButton.snp.bottom).offset(15)
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
        
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = L10n.TabBar.finance
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func navigateToTransactionsViewController() {
        let vc = FinanceTransactionListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToReportsViewController() {
        let vc = FinanceReportBalanceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToDocumentsViewController() {
        let vc = DocumentListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
