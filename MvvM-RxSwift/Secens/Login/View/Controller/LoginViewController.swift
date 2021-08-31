//
//  LoginViewController.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/28/21.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: CustomeTextFiled!
    @IBOutlet weak var passwordTF: CustomeTextFiled!
    @IBOutlet weak var loginButton: CustomButtom!
    @IBOutlet weak var toggleEyeButton: UIButton!
    
    let loginViewModel: LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    var isClicked = true
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextFieldToViewModel()
        subscribeToLoading()
        subdcribeToLoginButton()
        subscribeToResponse()
        isLoginEnable()
        handelToggleEye()
        navigationController?.isNavigationBarHidden = true
    }
    
    func bindTextFieldToViewModel() {
        emailTF.rx.text.orEmpty.bind(to: loginViewModel.emailBehavior).disposed(by: disposeBag)
       
        passwordTF.rx.text.orEmpty.bind(to: loginViewModel.passBehavior).disposed(by: disposeBag)
        debugPrint(loginViewModel.emailBehavior.value)
    }
    
    func subscribeToLoading() {
        loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.hud.show(in: self.view)
            } else {
                self.hud.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    
    func subscribeToResponse() {
        loginViewModel.loginModelObservable.subscribe(onNext: {
            if $0.pk == 1 {
                let vc = HomeViewController()
                vc.modalPresentationStyle = .fullScreen
                print($0.token ?? "")
                self.present(vc, animated: true)
            }
            else {
                
            }
        }).disposed(by: disposeBag)
    }
    
    func subdcribeToLoginButton() {
        loginButton.rx.tap.subscribe { [weak self] (_) in
            guard let self = self else {return}
            self.loginViewModel.getDate()
            print("Button tapped")
        }.disposed(by: disposeBag)
        
    }
    
    func isLoginEnable() {
        loginViewModel.isLoginButtonEnapled.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func handelToggleEye() {
        toggleEyeButton.addTarget(self, action: #selector(showAndHidePass), for: .touchUpInside)
    }
    
    @objc func showAndHidePass() {
        
        if isClicked == true {
            passwordTF.isSecureTextEntry = false
            toggleEyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            
        }
        else {
            passwordTF.isSecureTextEntry = true
            toggleEyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
        isClicked = !isClicked
    }
}
