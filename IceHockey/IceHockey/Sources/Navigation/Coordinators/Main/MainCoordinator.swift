//
//  MainCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import UIKit

enum CoordinatorCommand {
    case push(UIViewController)
    case popToRoot
    case back
}

enum ApplicationTab {
    case news
    case trainings
    case squads
    case finance
    case profile
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput, MainCoordinatorProtocol {
    
    var finishFlow: CompletionBlock?
    
    weak var delegate: MainCoordinatorDelegate!
    var tabs: [ApplicationTab: Coordinatable] = [:]
    
    let router: Routable
    fileprivate let factory: ModulesFactory
    
    init(router: Routable, factory: ModulesFactory) {
        self.router = router
        self.factory = factory
    }
    
    func switchToTab(_ tab: ApplicationTab, animated: Bool) {
        guard let tab = tabs[tab],
              let viewControllers = delegate.viewControllers
        else { return }
        
        let navigationController = tab.getNavigationController()
        
        DispatchQueue.main.async {
            if let (index, _) = viewControllers.enumerated().first(where: { $1 === navigationController }) {
                self.delegate.switchTab(at: index)
            }
        }
    }
    
    func execute(command: CoordinatorCommand, at tab: ApplicationTab, animated: Bool) {
        guard let coordinator = getCoordinator(with: tab) else { return }
        execute(command: command, on: coordinator, animated: animated)
    }
    
}

extension MainCoordinator: Coordinatable {
    func getNavigationController() -> UINavigationController {
        fatalError("Main coordinator doesn't have navigation controller")
    }
    
    func start() {
        performFlow()
        updateCoordinatorsList()
    }
}

extension MainCoordinator {
    private func execute(command: CoordinatorCommand, on coordinator: Coordinatable, animated: Bool) {
        DispatchQueue.main.async {
            switch command {
            case .push(let vc):
                self.router.push(vc, animated: animated)
            case .popToRoot:
                self.router.popToRootModule(animated: animated)
            case .back:
                self.router.popModule(animated: animated)
            }
        }
    }
    
    private func getCoordinator(with type: ApplicationTab) -> Coordinatable? {
        tabs[type]
    }
    
    private func updateCoordinatorsList() {
        
        // prepare coordinators
        var childCoordinators: [Coordinatable] = []
        var tabs: [ApplicationTab: Coordinatable] = [:]
        
        var coordinator = prepareNewsCoordinator()
        childCoordinators.append(coordinator)
        tabs[.news] = coordinator
        
        coordinator = prepareTrainingScheduleCoordinator()
        childCoordinators.append(coordinator)
        tabs[.news] = coordinator
        
        coordinator = prepareContactsCoordinator()
        childCoordinators.append(coordinator)
        tabs[.news] = coordinator
        
        coordinator = prepareFinanceCoordinator()
        childCoordinators.append(coordinator)
        tabs[.news] = coordinator
        
        coordinator = prepareProfileCoordinator()
        childCoordinators.append(coordinator)
        tabs[.news] = coordinator
        
        self.childCoordinators = childCoordinators
        self.tabs = tabs
        
        DispatchQueue.main.async {
            self.startCoordinators()
            self.delegate?.tabsWasUpdated(self.childCoordinators.map { $0.getNavigationController() })
        }
        
    }
    
    private func startCoordinators() {
        log.debug("MainCoordinator startCoordinators executed")
        childCoordinators.forEach { $0.start() }
    }
    
}

// MARK: - Private methods
extension MainCoordinator {
    func performFlow() {
        let vc = factory.makeMainViewController()
        vc.onCompletion = finishFlow
        delegate = vc
        router.setRootModule(vc, hideBar: true)
    }
    
    func prepareNewsCoordinator() -> Coordinatable {
        let vc = factory.makeNewsViewController(),
            navigationController = NewsNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeNewsCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
    
    func prepareSquadsCoordinator() -> Coordinatable {
        let vc = factory.makeSquadsViewController(),
            navigationController = SquadsNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeSquadsCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
    
    func prepareTrainingScheduleCoordinator() -> Coordinatable {
        let vc = factory.makeTrainingScheduleViewController(),
            navigationController = TrainingScheduleNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeTrainingScheduleCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
    
    func prepareContactsCoordinator() -> Coordinatable {
        let vc = factory.makeContactsViewController(),
            navigationController = ContactsNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeContactsCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
    
    func prepareFinanceCoordinator() -> Coordinatable {
        let vc = factory.makeFinanceViewController(),
            navigationController = FinanceNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeFinanceCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
    
    func prepareProfileCoordinator() -> Coordinatable {
        let vc = factory.makeProfileViewController(),
            navigationController = ProfileNavigationController(rootViewController: vc),
            router = Router(rootController: navigationController),
            coordinator = CoordinatorFactory().makeProfileCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.start()
        }
        
        return coordinator
    }
}
