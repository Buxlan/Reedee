//
//  Onboarding.swift
//  Places
//
//  Created by  Buxlan on 5/6/21.
//

import UIKit
import UserNotifications

class OnboardingPageViewController: UIPageViewController, OnboardingViewProtocol {

    // MARK: - Properties
    
    var onCompletion: CompletionBlock?

    var currentIndex = 0
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.isUserInteractionEnabled = false
        view.pageIndicatorTintColor = Asset.other0.color
        view.currentPageIndicatorTintColor = Asset.main0.color
        return view
    }()
    lazy var items: [UIViewController] = {
        let viewModel1 = OnboardingViewModel(image: Asset.onboarding1.image,
                                             title: L10n.Onboarding.onboardngTitle1,
                                             text: L10n.Onboarding.onboardngText1,
                                             isButtonSkipEnabled: false)
        let firstOnboardingVC = OnboardingViewController(viewModel: viewModel1)
        firstOnboardingVC.onCompletion = { [weak self] in
            self?.onCompletion?()
        }
        
        let viewModel2 = OnboardingViewModel(image: Asset.onboarding2.image,
                                             title: L10n.Onboarding.onboardngTitle2,
                                             text: L10n.Onboarding.onboardngText2,
                                             isButtonSkipEnabled: false)
        let secondOnboardingVC = OnboardingViewController(viewModel: viewModel2)
        secondOnboardingVC.onCompletion = { [weak self] in
            self?.onCompletion?()
        }
        
        let viewModel3 = OnboardingViewModel(image: Asset.onboarding1.image,
                                             title: L10n.Onboarding.onboardngTitle3,
                                             text: L10n.Onboarding.onboardngText3,
                                             isButtonSkipEnabled: true)
        let thirdOnboardingVC = OnboardingViewController(viewModel: viewModel3)
        thirdOnboardingVC.onCompletion = { [weak self] in
            self?.onCompletion?()
        }
        
        let  items = [firstOnboardingVC, secondOnboardingVC, thirdOnboardingVC]
        return items
    }()
    
    // MARK: - Init
    init() {
        let options = [UIPageViewController.OptionsKey.interPageSpacing: 32]
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.addSubview(pageControl)
                
        setViewControllers([items[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        pageControl.numberOfPages = items.count
        
        configureConstraints()
        
    }
    
    // MARK: - Helper functions
    private func configureConstraints() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            pageControl.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,
                                                constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let vcs = pageViewController.viewControllers {
            let vc = vcs[0]
            if let index = items.firstIndex(of: vc) {
                pageControl.currentPage = index
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return nil
        guard let index = items.firstIndex(of: viewController) else {
            fatalError()
        }
        if index == 0 {
            return nil
        } else {
            let newIndex = index-1
            return items[newIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = items.firstIndex(of: viewController) else {
            fatalError()
        }
        if index == items.count-1 {
            return nil
        } else {
            let newIndex = index+1
            return items[newIndex]
        }
    }
    
}
