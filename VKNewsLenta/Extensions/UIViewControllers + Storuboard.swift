//
//  UIViewControllers + Storuboard.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation
import UIKit

//Расширение для UIViewController
extension UIViewController {
    
    //Функция которая будет использоваться для использования разных контроллеров по имени 
    class func loadFromStoryboard<T: UIViewController>() -> T {
        
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}
