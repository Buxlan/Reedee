//
//  StandAloneTransactionViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 16.10.2022.
//

import RxSwift
import RxCocoa


final class StandAloneTransactionViewModel: BaseViewModel {
    var disposeBag = DisposeBag()
    var statusRelay = BehaviorRelay<Status?>(value: nil)
    var uiRefreshHandler: () -> Void = {}
    
    func updateData() {
        
    }
}
