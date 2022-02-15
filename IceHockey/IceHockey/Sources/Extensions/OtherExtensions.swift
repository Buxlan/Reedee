//
//  Extensions.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import Firebase

extension UIView {
    // Function finds root view controller
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UIImageView {
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
            self.image = image
        }, completion: nil)
    }
}

// extension UITableView {
//    func perform(result: List.Result) {
//        if result.hasChanges {
//            self.beginUpdates()
//            if !(result.deletes.isEmpty) {
//                self.deleteRows(at: result.deletes.compactMap {
//                    IndexPath(row: $0, section: 0)
//                }, with: .automatic)
//            }
//            if !result.inserts.isEmpty {
//                self.insertRows(at: result.inserts.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
//            }
//            if !result.updates.isEmpty {
//                self.reloadRows(at: result.updates.compactMap { IndexPath(row: $0, section: 0) }, with: .automatic)
//            }
//            if !result.moves.isEmpty {
//                result.moves.forEach({ (index) in
//                    let toIndexPath = IndexPath(row: index.to, section: 0)
//                    self.moveRow(at: IndexPath(row: index.from, section: 0), to: toIndexPath)
//                })
//            }
//            self.endUpdates()
//        }
//    }
// }

extension UIButton {
    
    static func onboardingButton(title: String, image: UIImage?) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.backgroundColor = Asset.other0.color
        
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 12
        
        // configure insets
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
        
        return button
    }
    
}

extension Notification.Name {
    
    static let onboardingDismiss = Notification.Name("onboardingDismiss")
    
}

extension String {
    func localized() -> String {
        let str = NSLocalizedString(self, comment: "Comment for: \(self)")
        return str
    }
}

// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// MARK: - UIKit Extensions

extension UINavigationController {
    
    enum TitleType: CaseIterable {
        case regular, large
    }
    
    func setTitleColor(_ color: UIColor, _ types: [TitleType] = TitleType.allCases) {
        if types.contains(.regular) {
            navigationBar.titleTextAttributes = [.foregroundColor: color]
        }
        if types.contains(.large) {
            navigationBar.largeTitleTextAttributes = [.foregroundColor: color]
        }
    }
}

extension UITextField {
    func setImage(_ image: UIImage?) {
        guard let image = image else { return }
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 20, y: 0, width: 40, height: 40)
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
}

extension UIImageView {
    
    func setImage(from url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
                self.contentMode = .scaleAspectFit
            }
        }
    }
}

extension Date {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}

extension UITextView {
    
    func alignTextVerticallyInContainer() {
        var inset = (self.bounds.height - self.contentSize.height * self.zoomScale) / 2
        inset = inset < 0 ? 0.0 : inset
        self.contentInset.bottom = inset
    }
    
}

// MARK: UINavigationBar + UserDisplayable Protocol

protocol UserDisplayable {
    func addProfilePic(_ imageView: UIImageView)
}

extension UINavigationBar: UserDisplayable {
    func addProfilePic(_ imageView: UIImageView) {
        let length = frame.height * 0.46
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = length / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: length),
            imageView.widthAnchor.constraint(equalToConstant: length)
        ])
    }
}

extension String {
    static  var empty: String {
        return ""
    }    
}

extension Double {
    func round(to digits: Int,
               using rule: FloatingPointRoundingRule = .down)
    -> Double {
        let divisor = pow(10.0, Double(digits))
        var value = self * divisor
        value.round(rule)
        return value / divisor
    }
}
