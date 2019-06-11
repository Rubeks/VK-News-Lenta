//
//  NetworkDataFetcher.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 11/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation

//Тут реализация преобразования ответа от сервера в JSON и затем в объекты структуры

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        
        let params = ["filters" : "post, photo"]
        
        //Создание запроса по урл
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            
            if let error = error {
                print("Error requesting datta: \(error.localizedDescription)")
                response(nil)
            }
        
            //Преобразование json в объект струтуры
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    //Универсальная функция для декодирования json в структуру
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) ->T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard
            let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
