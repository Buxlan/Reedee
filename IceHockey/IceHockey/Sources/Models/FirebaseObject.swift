//
//  FirebaseObject.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Foundation

protocol FirebaseObject {
    
    static func getObject(by uid: String, completion handler: @escaping (Self?) -> Void)
    
    var uid: String { get set }
    
    init?(key: String, dict: [String: Any])
    
    func save() throws
    func delete() throws
    
}
