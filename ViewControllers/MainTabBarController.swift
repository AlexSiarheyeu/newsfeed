//
//  MainTabBarController.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedImage = UIImage(systemName: "newspaper.fill")!
        let settingsImage = UIImage(systemName: "gearshape.fill")!

        let feedVC = NewsfeedViewController()
        let settingsVC = SettingsViewController()
        
        viewControllers = [
            
            generateNavigationController(rootViewController: feedVC,
                                         title: "News",
                                         image: feedImage),
            
            generateNavigationController(rootViewController: settingsVC,
                                         title: "Settings",
                                         image: settingsImage)
        ]
    }
    
    func generateNavigationController(rootViewController: UIViewController,
                                      title: String,
                                      image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        return navigationVC
    }
    
}

