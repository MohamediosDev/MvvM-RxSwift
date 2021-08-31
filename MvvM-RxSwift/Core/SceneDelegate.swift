//
//  SceneDelegate.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/28/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        checkIN()
    }
    
    func checkIN() {
        
        if UserDefaults.standard.value(forKey: "#TEST22") != nil {
            let vc = HomeViewController()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        
        else {
            let vc = LoginViewController()
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = vc
            share?.window?.makeKeyAndVisible()
        }
    }
}

