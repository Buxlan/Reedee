//
//  FinanceTextReportViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.02.2022.
//

import SnapKit
import RxSwift
import RxCocoa
import UIKit

class FinanceTextReportViewController: UIViewController {
    
    // MARK: - Properties
    
    var text: String = "" {
        didSet {
            transactionsTextView.text = text
        }
    }
    
    private lazy var transactionsTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.Gray.medium.cgColor
        view.textColor = .black
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.isEditable = false
        view.font = Fonts.Regular.subhead
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.Gray.light
        
        view.addSubview(transactionsTextView)
        
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBars()
    }
    
}

// MARK: - Helpers

extension FinanceTextReportViewController {
    
    private func configureConstraints() {
        
        transactionsTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalToSuperview().offset(-32)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = false
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = L10n.Finance.exportBalance
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

// MARK: - Text view delegate

extension FinanceTextReportViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}
