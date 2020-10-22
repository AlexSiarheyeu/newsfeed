//
//  ViewController.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import UIKit
import VK_ios_sdk


class AuthViewController: UIViewController  {
    
    var authService: AuthService!
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3618676233, green: 0.561070992, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let vkImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "vk"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        authService = AppDelegate.shared().authService
        
    }
    
    @objc func handleLogIn() {
        authService.wakeUpSession()
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        view.addSubview(logInButton)
        view.addSubview(vkImageView)
        NSLayoutConstraint.activate([
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            vkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            
        ])
        
        logInButton.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
    }
}
