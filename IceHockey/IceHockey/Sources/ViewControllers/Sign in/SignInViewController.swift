//
//  SignInViewController.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel = SignInViewModel()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.accessibilityIdentifier = "logoImageView"
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        let image = Asset.logo.image
        view.setImage(image)
        return view
    }()
    
    private lazy var loginTextField = LoginTextField()    
    private lazy var passwordTextField = PasswordTextField()
    
    private lazy var signInButton: UIButton = {
        let view = UIButton()
        view.setTitle("Sign in", for: .normal)
        view.backgroundColor = Colors.Accent.blue
        view.setTitleColor(.white, for: .normal)
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 8
        view.contentEdgeInsets = .init(top: 8, left: 12, bottom: 8, right: 12)
        return view
    }()
    
    private lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Accent.blue
        return view
    }()
    
    // MARK: - Lifecircle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewModel()
    }

}

// MARK: - Helper methods

extension SignInViewController {
    
    private func configureViewModel() {
        loginTextField.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.loginBehaviorRelay)
            .disposed(by: viewModel.disposeBag)
        passwordTextField.rx.text
            .map { $0 ?? ""}
            .bind(to: viewModel.passwordBehaviorRelay)
            .disposed(by: viewModel.disposeBag)
        signInButton.rx.tap.bind {
            print("button tapped")
        }.disposed(by: viewModel.disposeBag)
        viewModel.isValid()
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: viewModel.disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.Gray.ultraLight
        view.addSubview(topBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        topBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.top)
            make.centerX.equalTo(view.layoutMarginsGuide.snp.centerX)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.height.equalTo(view.snp.width).multipliedBy(0.5)
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.layoutMarginsGuide.snp.width).offset(-32)
            make.height.equalTo(36)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.layoutMarginsGuide.snp.width).offset(-32)
            make.height.equalTo(36)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        
        
    }
    
}
