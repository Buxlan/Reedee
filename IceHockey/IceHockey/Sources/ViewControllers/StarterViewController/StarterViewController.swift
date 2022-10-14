//
//  StarterViewController.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 21.03.2022.
//

import SnapKit

class StarterViewController: UIViewController, StarterViewProtocol {
    
    var onCompletion: CompletionBlock?
    
    let logoImage = Asset.logo.image
        
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = logoImage
        
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        print("StarterViewController init")
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("StarterViewController viewDidLoad")
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        configureConstraints()
        
        showProgress(title: L10n.loading, subTitle: "")
        AuthManager.shared.addObserver(self)
        
    }
    
    deinit {
        print("StarterViewController Deinit")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AuthManager.shared.removeObserver(self)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(logoImage.size.width)
            make.height.equalTo(logoImage.size.height)
        }
    }
    
}

extension StarterViewController: AuthObserver {
    
    func didChangeUser(_ user: ApplicationUser) {
        hideProgress()
        Session.isAppLoaded = true
        onCompletion?()
    }
    
}

