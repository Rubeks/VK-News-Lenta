//
//  NetworkService.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation

// Сервис-менеджер для рабаьы с сетью

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    //Создание url адреса
    func getFeed() {
        
        //Создание веб адреса. Позволит создавать адрес из составных частей.
        var components = URLComponents()
   
        //Проверяет токен(ид) пользователя
        guard let token = authService.token else { return }
        
        //Параметры path
        let params = ["filters" : "post, photo"]
        var allparams = params
        
        //Добавление
        allparams["access_token"] = token
        allparams["v"] = API.version
        
        //scheme - протокол http или https
        components.scheme = API.scheme
        
        //host - название сайта с которого производится запрос
        components.host = API.host
        
        //path - к какому методу будет производится запрос
        components.path = API.newsFeed
        
        //queryItems - параметры. Для каждого метода они свои. $0 для каждого ключа словаря $1 свое значение
        components.queryItems = allparams.map { URLQueryItem(name: $0, value: $1)}
        
        //Собранный вместе url
        let url = components.url!
        print(url)
    }
}
