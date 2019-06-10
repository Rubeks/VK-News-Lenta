//
//  AuthService.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation
import VKSdkFramework

//Протокол для авторизации
protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

//Класс авторизации
final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    //id приложения с сайта VK
    private let appId = "7016129"
    private let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    //Токен. Типо ключа id у каждого пользователя. Уникален.
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        
        print("VKSdk.initialize")
        
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    //Срабатывает при нажатие "Войти в ВК"
    func wakeUPSession() {
    
        let scope = ["offline"]
        
        //Пытается извлеч токен из хранилища и проверяет разрешено ли приложению использовать токен к доступу
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            
            //Человек уже авторизирован
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
               delegate?.authServiceSignIn()
                
            //Человек собирается авторизироваться
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    //MARK: - VKsdk Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        
        if result.token != nil {
              delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
         print(#function)
    }
    
    //MARK: - VKsdk UIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
         print(#function)
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
         print(#function)
    }
}
