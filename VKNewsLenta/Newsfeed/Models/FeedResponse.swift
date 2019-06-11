//
//  FeedResponse.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 11/06/2019.
//  Copyright © 2019 Раис Аглиуллов. All rights reserved.
//

import Foundation

//Структуры которые будут заполнятьс при парсе JSON

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
