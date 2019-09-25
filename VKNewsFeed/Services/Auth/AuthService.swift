//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Serg on 04/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import VK_ios_sdk

final class AuthService: NSObject {
    
    private let appId = "7043973"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    // Инициализируйте SDK с помощью своего APP_ID
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VkSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSeccion() {
        let scope = ["wall", "friends", "offline"]
        
        //необходимо проверить, доступна ли предыдущая сессия
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
                
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
}

    // MARK: VKSdkDelegate

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
            
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
}

    // MARK: VKSdkUIDelegate

extension AuthService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}

    // MARK: AuthServiceProtocol

extension AuthService: AuthServiceProtocol {
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
}
