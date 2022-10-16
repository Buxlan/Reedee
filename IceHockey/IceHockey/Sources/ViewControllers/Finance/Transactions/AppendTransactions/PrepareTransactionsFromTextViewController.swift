//
//  AppendTransactionsFromTextViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.02.2022.
//

import SnapKit
import RxSwift
import RxCocoa
import UIKit

class PrepareTransactionsFromTextViewController: UIViewController {
    
    // MARK: - Properties
    
    static let str = """
    1    ФИО    #Номер    Сумма    Комментарий
    """
    
    var onNext = {}
    var text: String = PrepareTransactionsFromTextViewController.str
    var amount: Double = 0.0
    var comment: String = ""
    var isCommonAmount = false
    
    private var disposeBag = DisposeBag()
    
    private var type: TransactionType
    
    private lazy var amountTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.textColor = .black
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.cornerRadius = 6
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Finance.Transactions.amountPlaceholer,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark]
        )
        return view
    }()
    
    private lazy var commonAmountCheckBox: CheckBox = {
        let view = CheckBox()
        view.setTitle("Общая сумма", for: .normal)
        view.backgroundColor = .clear
        view.tintColor = Asset.textColor.color
        view.action = { [weak self] isSelected in
            self?.isCommonAmount = isSelected
        }
        return view
    }()
    
    private lazy var commentTextField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.textColor = .black
        view.backgroundColor = .white
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.cornerRadius = 6
        view.inputAccessoryView = keyboardAccessoryView
        view.attributedPlaceholder = NSAttributedString(
            string: L10n.Finance.Transactions.commentPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.Gray.dark]
        )
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
        view.inputAccessoryView = keyboardAccessoryView
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
    
    private lazy var keyboardAccessoryView: DoneKeyboardAccessoryView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = DoneKeyboardAccessoryView(frame: frame)
        view.delegate = self
        return view
    }()
    
    private var keyboardManager = KeyboardAppearanceManager()
    
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
        view.addSubview(commonAmountCheckBox)
        view.addSubview(commentTextField)
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
        
        commentTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] value in
                self?.comment = value
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

extension PrepareTransactionsFromTextViewController {
    
    private func configureConstraints() {
        
        amountTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.trailing.equalTo(commonAmountCheckBox.snp.leading).offset(-16).priority(250)
            make.height.equalTo(40)
        }
        
        commonAmountCheckBox.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
//            make.width.equalTo(120).priority(750)
            make.height.equalTo(40)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(amountTextField.snp.bottom).offset(8)
            make.width.equalToSuperview().offset(-32)
            make.height.equalTo(40)
        }
        
        transactionsTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(commentTextField.snp.bottom).offset(8)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalTo(nextButton.snp.top).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-8)
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
    
}

// MARK: - Text field delegate

extension PrepareTransactionsFromTextViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case amountTextField:
            commentTextField.becomeFirstResponder()
        default:
            transactionsTextView.becomeFirstResponder()
        }
        return true
    }
    
}

// MARK: - Text view delegate

extension PrepareTransactionsFromTextViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            textView.becomeFirstResponder()
            textView.selectAll(self)
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}

// MARK: -

extension PrepareTransactionsFromTextViewController: DoneKeyboardAccessoryViewDelegate {
    
    func onDone() {
        handleDoneButton()
    }
    
}

// MARK: - Actions

extension PrepareTransactionsFromTextViewController {
    
    @objc private func onNextHandle() {
        onNext()
    }
    
    private func handleDoneButton() {
        view.subviews.forEach { (view) in
            if view.isFirstResponder {
                view.resignFirstResponder()
                return
            }
        }
    }
    
}
