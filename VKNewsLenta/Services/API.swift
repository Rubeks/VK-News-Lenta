//
//  API.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 10/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation

//Структура которая будет содержать составные части url запроса
struct API {
    
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.95"
    
    //У URLComponents() из составных частей есть "path" в данном случае будет newsFeed - т.е новостная лента.
    //Для получения других данных нужно будет селать новый path
    static let newsFeed = "/method/newsfeed.get"
}
