//
//  AppDelegate.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import UIKit
import VK_ios_sdk

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        authService = AuthService()
        authService.authDelegate = self
        window?.rootViewController = AuthViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        
        return true
    }
    
    func authServiceShouldShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil )
    }
    
    func authServiceSignIn() {
        let tabBarVC = MainTabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(tabBarVC, animated: true, completion: nil)
    }
    
    func authServiceSignDidFail() {
        print(#function)
    }
}

