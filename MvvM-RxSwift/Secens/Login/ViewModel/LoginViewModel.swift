//
//  LoginViewModel.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/28/21.
//

import RxSwift
import RxCocoa
import Alamofire


class LoginViewModel {
    
    var emailBehavior = BehaviorRelay<String>(value: "")
    var passBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var loginModelSubject = PublishSubject<LoginSucessModel>()
    
    var isEmailVaild: Observable<Bool> {
        
        return emailBehavior.asObservable().map { (email) -> Bool in
            let isEmailEmpty = email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isEmailEmpty
        }
    }
    
    var isPassVaild: Observable<Bool> {
        
        return passBehavior.asObservable().map { (pass) -> Bool in
            let isPassEmpty = pass.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return isPassEmpty
        }
    }
    
    var isLoginButtonEnapled: Observable<Bool> {
        return Observable.combineLatest(isEmailVaild, isPassVaild) { (isEmailEmpty, isPassEmpty) in
            let loginValid = !isEmailEmpty && !isPassEmpty
            return loginValid
        }
    }
    
    var loginModelObservable: Observable<LoginSucessModel>{
        return loginModelSubject
    }
    
    
    
    
    func getDate() {
        
        loadingBehavior.accept(true)
        let url = "https://egylearn.herokuapp.com/api/account/login"
        
        let param = [
            "email_or_username": emailBehavior.value,
            "password": passBehavior.value
        ]
        
        ApiService.Shared.fetchData(url: url, parms: param, headers: nil, method: .post) { [weak self] (sucess: LoginSucessModel?, fail:LoginErrorModel?, error) in
            self?.loadingBehavior.accept(false)
            guard let self = self else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            
            else if let errordata = fail {
                print(errordata.errorMessage ?? "")
            }
            
            else {
                guard let loginSucess = sucess else { return }
                self.loginModelSubject.onNext(loginSucess)
                NetworkHelper.accessToken = loginSucess.token
                UserDefaults.standard.set(loginSucess.email, forKey: "IDUSER")
                UserDefaults.standard.setValue(loginSucess.username, forKey: "#TEST22")
            }
        }
    }
    
}

extension LoginViewController {
    
    static func instantiate() -> LoginViewController {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyBoard.instantiateInitialViewController() as!  LoginViewController

        return vc
    }
}
