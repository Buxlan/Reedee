//
//  DataSnapshotsPortionCollection + Iterator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/25/21.
//

import Firebase
import UIKit

class DataSnapshotsPortionCollection {
    
    typealias Element = DataSnapshot
    var items: [Element] = []
    
    func append(_ item: Element) {
        self.items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
}
