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
    var profiles: [Profile]
    var groups: [Group]
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

//Структуры для груп и людей которые постили
protocol ProfileRepresenatable {
    var id: Int { get }
    var name : String { get }
    var photo: String { get }
}

struct Profile: Decodable, ProfileRepresenatable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
    
}

struct Group: Decodable, ProfileRepresenatable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}
