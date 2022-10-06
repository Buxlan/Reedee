//
//  ObjectAssociation.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.03.2022.
//

import UIKit

public final class ObjectAssociation<T: AnyObject> {
    
    private let policy: objc_AssociationPolicy
    
    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        
        self.policy = policy
    }
    
    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        
        get {
            let value = objc_getAssociatedObject(index,
                                                 Unmanaged.passUnretained(self).toOpaque())
            guard let value = value as? T? else { fatalError() }
            return value
        }
        set {
            objc_setAssociatedObject(
                index,
                Unmanaged.passUnretained(self).toOpaque(), newValue, policy)
        }
        
    }
}
