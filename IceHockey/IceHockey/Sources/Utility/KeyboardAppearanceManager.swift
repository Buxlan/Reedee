//
//  KeyboardAppearanceManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import UIKit

class KeyboardAppearanceManager {
    weak var scrollView: UIScrollView?
    
    // Handling keyboard state
    enum KeyboardState {
        case unknown
        case entering
        case exiting
    }
    private lazy var oldContentInset: UIEdgeInsets = {
        self.scrollView?.contentInset ?? .zero
    }()
    private lazy var oldOffset: CGPoint = {
        self.scrollView?.contentOffset ?? .zero
    }()
    
    func register(scrollView: UIScrollView) {
        self.scrollView = scrollView
        registerObservers()
    }
    
    func unregister() {
        scrollView = nil
    }
    
    deinit {
        unregisterObservers()
    }
    
}

extension KeyboardAppearanceManager {
    
    // Subscribe to keyboard showing/hiding
    private func registerObservers() {        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func keyboardState(for dictionary: [AnyHashable: Any], in view: UIView?) -> (KeyboardState, CGRect?) {
        
        guard var rectOld = dictionary[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
              var rectNew = dictionary[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let view = view else {
            print("Something goes wrong")
            return (KeyboardState.unknown, CGRect.zero)
        }
        var keyboardState: KeyboardState = .unknown
        var newRect: CGRect?
        let co = UIScreen.main.coordinateSpace
        rectOld = co.convert(rectOld, to: view)
        rectNew = co.convert(rectNew, to: view)
        newRect = rectNew
        if !rectOld.intersects(view.bounds) && rectNew.intersects(view.bounds) {
            keyboardState = .entering
        }
        if rectOld.intersects(view.bounds) && !rectNew.intersects(view.bounds) {
            keyboardState = .exiting
        }
        return (keyboardState, newRect)
    }
    
    @objc private func keyboardShow(_ notification: Notification) {
        let dict = notification.userInfo!
        let (state, rnew) = keyboardState(for: dict, in: self.scrollView)
        if state == .unknown {
            return
        } else if state == .entering {
            self.oldContentInset = self.scrollView?.contentInset ?? .zero
            self.oldOffset = self.scrollView?.contentOffset ?? .zero
        }
        if let rnew = rnew {
            let height = rnew.intersection(self.scrollView?.bounds ?? .zero).height
            self.scrollView?.contentInset.bottom = height
        }
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        let dict = notification.userInfo!
        let (state, _) = keyboardState(for: dict, in: self.scrollView)
        if state == .exiting {
            self.scrollView?.contentOffset = self.oldOffset
            self.scrollView?.contentInset = self.oldContentInset
        }
    }
    
}
