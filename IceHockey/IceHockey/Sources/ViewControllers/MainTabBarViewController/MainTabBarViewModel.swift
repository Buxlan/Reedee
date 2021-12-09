//
//  MainTabBarViewModel.swift
//  Places
//
//  Created by  Buxlan on 9/4/21.
//
import UIKit

class MainTabBarViewModel {
    
    enum ViewControllerData: Int, CustomStringConvertible {
        case home
        case ourSquads
        case ourContacts
        case profile
        
        init(rawValue: Int) {
            switch rawValue {
            case 0:
                self = .home
            case 1:
                self = .ourSquads
            case 2:
                self = .ourContacts
            default:
                self = .profile
            }
        }
        
        var description: String {
            switch self {
            case .home:
                return L10n.Squads.tabBarItemTitle
            case .ourSquads:
                return L10n.Squads.trainingTitle
            case .ourContacts:
                return L10n.Contacts.title
            case .profile:
                return L10n.Profile.title
            }
        }
        
        var image: UIImage {
            let height: CGFloat = 24
            switch self {
            case .home:
                return Asset.home.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysTemplate)
            case .ourSquads:
                return Asset.person3.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysTemplate)
            case .ourContacts:
                return Asset.contacts.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysTemplate)
            case .profile:
                return Asset.gear.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysTemplate)
            }
        }
        
        var selectedImage: UIImage {
            let height: CGFloat = 24
            switch self {
            case .home:
                return Asset.homeFill.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysOriginal)
            case .ourSquads:
                return Asset.person3Fill.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysOriginal)
            case .ourContacts:
                return Asset.contacts.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysOriginal)
            case .profile:
                return Asset.gearFill.image.resizeImage(to: height, aspectRatio: .current)
                    .withRenderingMode(.alwaysTemplate)
            }
        }
        
    }
    
    lazy var viewControllers: [UIViewController] = {
        var items = [UIViewController]()
        var vc: UINavigationController
        vc = UINavigationController(rootViewController: HomeViewController())
        items.append(vc)        
                
        vc = UINavigationController(rootViewController: TrainingScheduleViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: ContactsViewController())
        items.append(vc)
        
        vc = UINavigationController(rootViewController: SettingsViewController())
        items.append(vc)
        
        return items
    }()
    
    func configureTabBarItems(_ items: [UITabBarItem]?) {
        guard let items = items else {
            return
        }
        for (index, item) in items.enumerated() {
            let data = ViewControllerData.init(rawValue: index)
            item.title = data.description
            item.image = data.image
            item.selectedImage = data.selectedImage
        }
    }
    
}
