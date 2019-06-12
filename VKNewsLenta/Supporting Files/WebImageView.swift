//
//  WebImageView.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 12/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

//Файл для загрузки изображения

class WebImageView: UIImageView {
    
    func set(imageURL: String) {
        
        guard let url = URL(string:  imageURL) else { return }
        
        //кэширование изображения
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    
                    //добавление изображения в кэш
                    self?.handleLoadImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    //обработка изображения
    private func handleLoadImage(data: Data, response: URLResponse) {
        
        guard let responseURL = response.url else { return }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
