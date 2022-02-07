//
//  AppendTransactionsViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import SnapKit
import RxSwift
import RxCocoa
import UIKit

class AppendTransactionsViewController: UIViewController {
    
    // MARK: - Properties
    
    static let str = """
    1    Бушмакин Егор    14 300 Взнос
    2    Валиуллин Айман    88 300
    3    Вилков Александр    28 300
    4    Дзодзуашвили Георгий    30
    5    Егоров Михаил    15
    6    Иванов Дима    21
    7    Ишимов Марк    27
    8    Климонов Даниил    17
    9    Колесниченко Константин    55
    10    Круглов Иван    31
    11    Кудимов Дмитрий    5
    12    Курьянов Вселовод    1
    13    Кутейкин Владимир    45
    14    Лабунский Филипп    11
    15    Магнев Даниил    9
    16    Манько Платон    43
    17    Моисеев Максим    13
    18    Москвитин Федор    7
    19    Плугин Виктор    10
    20    Погонченков Геннадий    3
    21    Пшенко Марк    22
    22    Румянцев Дмитрий    99
    23    Сидоренко Даниил    78
    24    Фатхтдинов Артём    19
    25    Шаталов Егор    8
    """
    
    var onNext = {}
    var text: String = AppendTransactionsViewController.str
    var amount: Double = 0.0
    
    private var disposeBag = DisposeBag()
    
    private var type: TransactionType
    
    private lazy var amountTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.placeholder = L10n.Finance.Transactions.amount
        view.textColor = .black
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.cornerRadius = 6
        view.keyboardType = .numberPad
        return view
    }()
    
    private lazy var transactionsTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.Gray.medium.cgColor
        view.textColor = .black
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.isEditable = true
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.setTitle(L10n.Common.next, for: .normal)
        view.layer.cornerRadius = 6
        view.backgroundColor = Asset.accent1.color
        view.setTitleColor(Colors.Gray.ultraLight, for: .normal)
        view.titleLabel?.font = Fonts.Regular.subhead
        view.addTarget(self, action: #selector(onNextHandle), for: .touchUpInside)
        return view
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
        
        view.backgroundColor = Colors.Gray.light
        
        view.addSubview(amountTextField)
        view.addSubview(nextButton)
        view.addSubview(transactionsTextView)
        
        configureConstraints()
        
        amountTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                if let amount = Double(value) {
                    self?.amount = amount
                }
            }).disposed(by: disposeBag)
        
        transactionsTextView.text = text
        transactionsTextView.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.text = value
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBars()
    }
    
}

// MARK: - Helpers

extension AppendTransactionsViewController {
    
    private func configureConstraints() {
        
        amountTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        transactionsTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(amountTextField.snp.bottom).offset(16)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalTo(nextButton.snp.top).offset(-16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(44)
        }
        
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = type == .income ? L10n.Finance.Transactions.income : L10n.Finance.Transactions.costs
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func navigateToTransactionsViewController() {
        let vc = FinanceTransactionListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToReportsViewController() {
        let vc = FinanceReportsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Text field delegate

extension AppendTransactionsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = Double(string) {
            return true
        }
        return false
    }
    
}

// MARK: - Text view delegate

extension AppendTransactionsViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}

// MARK: - Actions

extension AppendTransactionsViewController {
    
    @objc private func onNextHandle() {
        onNext()
    }
    
}
