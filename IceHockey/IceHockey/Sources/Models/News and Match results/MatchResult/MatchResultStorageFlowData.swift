//
//  MatchResultStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

protocol MatchResultStorageFlowData {
    func load(with completionHandler: @escaping () -> Void)
}

extension MatchResultStorageFlowData {
    func load(with completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

struct DefaultMatchResultStorageFlowData: MatchResultStorageFlowData {
}

class MatchResultStorageFlowDataImpl: MatchResultStorageFlowData {
}
