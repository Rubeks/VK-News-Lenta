//
//  FeedViewController.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        networkService.getFeed()
    }
}
