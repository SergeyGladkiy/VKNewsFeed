//
//  NewsFeedItem.swift
//  VKNewsFeed
//
//  Created by Serg on 11/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ItemNewsfeed {
    var iconUrlString: String
    var name: String
    var date: String
    var text: String
    var likes: String
    var comments: String
    var shares: String
    var views: String
    
    init(iconUrl: String, name: String, date: String, text: String, likes: String, comments: String, shares: String, views: String) {
        self.iconUrlString = iconUrl
        self.name = name
        self.date = date
        self.text = text
        self.likes = likes
        self.shares = shares
        self.comments = comments
        self.views = views
    }
}
