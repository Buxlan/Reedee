//
//  Alertable.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 20.03.2022.
//

import UIKit

protocol Alertable: AnyObject {
    func showAlert(title: String,
                   message: String?,
                   style: UIAlertController.Style,
                   completion: (() -> Void)?)
}
