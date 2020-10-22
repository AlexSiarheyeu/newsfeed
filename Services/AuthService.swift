//
//  AuthService.swift
//  VKClient
//
//  Created by Alexey Sergeev on 10/21/20.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let vkId = "7636218"
    private var vkSdk: VKSdk
    weak var authDelegate: AuthServiceDelegate?
    
    var uniqueToken: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: vkId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends"]
        VKSdk.wakeUpSession(scope) { [self] (state, error) in
            
            if state == .initialized {
                VKSdk.authorize(scope)
            } else if state == .authorized {
                authDelegate?.authServiceSignIn()
            } else {
                authDelegate?.authServiceSignDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if  result.token != nil {
            authDelegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        authDelegate?.authServiceSignDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        authDelegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
           print(#function)
    }
}
