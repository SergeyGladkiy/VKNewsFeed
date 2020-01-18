//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Serg on 07/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

class FeedResponse: Decodable {
    var items: [FeedItem] = []
    var profiles: [Profile] = []
    var groups: [Group] = []
    var nextFrom: String?
    
    init() {
        
    }
    
    init(items: [FeedItem], profiles: [Profile], groups: [Group], nextFrom: String?) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
    
}


