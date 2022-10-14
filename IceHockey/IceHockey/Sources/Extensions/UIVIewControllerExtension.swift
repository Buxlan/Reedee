//
//  UIVIewController.swift
//  Places
//
//  Created by  Buxlan on 8/30/21.
//

import UIKit

// MARK: - UIKit Extensions

extension UIViewController {
    public func displayError(_ error: Error?, from function: StaticString = #function) {
        guard let error = error else { return }
        print("ⓧ Error in \(function): \(error.localizedDescription)")
        let message = "\(error.localizedDescription)\n\n Ocurred in \(function)"
        let errorAlertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        errorAlertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(errorAlertController, animated: true, completion: nil)
    }
    
}

extension UIViewController: ProgressPresenting { }

extension UIViewController: Presentable, Alertable {
    
    var toPresent: UIViewController? {
        return self
    }
    
    func showAlert(title: String,
                   message: String? = nil,
                   type: AlertType = .ok,
                   completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.Other.ok, style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
