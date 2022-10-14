//
//  BaseViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<ViewModelType: BaseViewModel>: UIViewController {
    
    var viewModel = ViewModelType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subsribeToStatusProcessing()
    }
    
}

extension BaseViewController {
    
    private func subsribeToStatusProcessing() {
        viewModel.statusRelay
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] status in
                guard let status = status else {
                    self?.hideProgress()
                    return
                }
                switch status {
                case .progress(let title, let subtitle):
                    if title.isEmpty, (subtitle?.isEmpty ?? true) {
                        self?.hideProgress()
                    } else {
                        self?.showProgress(title: title, subTitle: subtitle)
                    }
                case .alert(let title, let message, let type):
                    self?.showAlert(title: title, message: message, type: type)
                case .success(let title, let subtitle, let handler):
                    self?.showAlert(title: title, message: subtitle, completion: handler)
                default:
                    log.debug("This status \(status.description) isn't processing")
                }
            }).disposed(by: viewModel.disposeBag)
    }
    
}
