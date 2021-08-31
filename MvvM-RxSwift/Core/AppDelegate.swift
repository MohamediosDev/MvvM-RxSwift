
//  AppDelegate.swift
//  MvvM-RxSwift
//  Created by Soda on 8/28/21.


import UIKit
import SwiftMessages

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let rech = Reachability()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupUI()
        
        do {
            try rech?.startNotifier()
        }
        catch let error {
            
            print(error)
        }
        handleRech()
        
        return true
    }
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        rech?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: rech)
    }
    
    func setupUI() {
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 24 )!]
    }
    
    func handleRech() {
        
        NotificationCenter.default.addObserver(forName: .reachabilityChanged, object: rech, queue: .main) { (notify) in
            guard let myRech = notify.object as? Reachability else {return}
            
            switch myRech.connection {
            case.cellular:
                self.displayMessage(message: "Connected With Cellular data", messageError: false)
            case.wifi:
                self.displayMessage(message: "Connected With Wifi data", messageError: false)
            case.none:
                self.displayMessage(message: "Not Connected", messageError: true)
                
            }
        }
    }
    
    func displayMessage(message: String, messageError: Bool) {
        
        let view = MessageView.viewFromNib(layout: MessageView.Layout.messageView)
        if messageError == true {
            view.configureTheme(.error)
        } else {
            view.configureTheme(.success)
        }
        
        view.iconImageView?.isHidden = true
        view.iconLabel?.isHidden = true
        view.titleLabel?.isHidden = true
        view.bodyLabel?.text = message
        view.titleLabel?.textColor = UIColor.white
        view.bodyLabel?.textColor = UIColor.white
        view.button?.isHidden = true
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        SwiftMessages.show(config: config, view: view)
    }
    
    
    
}

