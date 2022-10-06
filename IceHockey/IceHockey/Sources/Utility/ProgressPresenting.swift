//
//  ProgressPresenting.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 21.03.2022.
//

import UIKit
import MBProgressHUD

let association = ObjectAssociation<NSObject>()

protocol ProgressPresenting: AnyObject {
    func showProgress(title: String, subTitle: String?)
    func showProgress(title: String, subTitle: String?, view: UIView)
    func showAutoHideMessage(title: String)
    func hideProgress()
}

extension ProgressPresenting where Self: UIViewController {
    var progressHUD: NSObject? {
        get { return association[self] }
        set { association[self] = newValue }
    }
    
    func showProgress(title: String, subTitle: String?) {
        self.hideProgress()
        let ph = MBProgressHUD.showAdded(to: self.view, animated: true)
        ph.label.text = title
        ph.detailsLabel.text = subTitle
        self.progressHUD = ph
    }
    
    func showProgress(title: String, subTitle: String?, _ duration: Int? = 30) {
        self.showProgress(title: title, subTitle: subTitle)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration!)) { () -> Void in
            self.hideProgress()
        }
    }
    
    func showProgress(title: String, subTitle: String?, view: UIView) {
        self.hideProgress()
        let ph = MBProgressHUD.showAdded(to: view, animated: true)
        ph.label.text = title
        ph.detailsLabel.text = subTitle
        self.progressHUD = ph
    }

    func showProgress(title: String, subTitle: String?, view: UIView, _ duration: Int? = 30) {
        self.showProgress(title: title, subTitle: subTitle, view: view)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration!)) { () -> Void in
            self.hideProgress()
        }
    }
    
    func showProgress(subTitle: String?) {
        if let ph = self.progressHUD as? MBProgressHUD {
            ph.detailsLabel.text = subTitle
            self.progressHUD = ph
        }
    }

    func showProgress(subTitle: String?, _ view: UIView, _ duration: Int? = 30) {
        self.hideProgress()
        let ph = MBProgressHUD.showAdded(to: view, animated: true)
        ph.label.text = ""
        ph.detailsLabel.text = subTitle
        self.progressHUD = ph
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(duration!)) { () -> Void in
            self.hideProgress()
        }
    }

    func showAutoHideMessage(title: String) {
        self.hideProgress()
        let ph = MBProgressHUD.showAdded(to: self.view, animated: true)
        ph.label.text = title
        ph.hide(animated: true, afterDelay: 10)
        self.progressHUD = ph
    }
    
    func hideProgress() {
        if let ph = self.progressHUD as? MBProgressHUD {
            ph.hide(animated: false)
        }
    }
}
