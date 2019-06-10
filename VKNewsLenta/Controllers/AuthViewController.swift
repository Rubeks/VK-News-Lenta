//
//  AuthViewController.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authService = AppDelegate.shared().authService
    }

    @IBAction func signInTouch() {
        authService.wakeUPSession()
    }
}
