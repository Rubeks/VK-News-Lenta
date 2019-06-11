//
//  NetworkService.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation

//протокол для реализации метода создания запроса
protocol Networking {
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void)
}

// Сервис-менеджер для рабаьы с сетью
final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    //Метод для Создания url адреса по параметрам
    private func url(from path: String, params: [String : String]) -> URL {
        
        //Создание веб адреса. Позволит создавать адрес из составных частей.
        var components = URLComponents()
        
        //scheme - протокол http или https
        components.scheme = API.scheme
        
        //host - название сайта с которого производится запрос
        components.host = API.host
        
        //path - к какому методу будет производится запрос
        components.path = API.newsFeed
        
        //queryItems - параметры. Для каждого метода они свои. $0 для каждого ключа словаря $1 свое значение
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        
        //Собранный вместе url
        return components.url!
    }
    
    //Функция для получения данных
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, request, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    //Получение данных
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        
        //Проверяет токен(ид) пользователя
        guard let token = authService.token else { return }
        
        //Параметры path
        var allparams = params
        
        //Добавление
        allparams["access_token"] = token
        allparams["v"] = API.version
        
        //Сам url
        let url = self.url(from: path, params: allparams)
        
        let request = URLRequest(url: url)
        
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
    }
}
