//
//  Log.swift
//  Places
//
//  Created by  Buxlan on 6/4/21.
//

import Foundation

struct Log {
    
    @discardableResult
    init(text: String, object: Any? = nil) {
        Utils.log(text, object: object)
    }
}
