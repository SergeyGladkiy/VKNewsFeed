//
//  NewsFeedData.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct NewsFeedData {
    var items: [NewsFeedElement] = []
    var profiles: [Profile] = []
    var groups: [Group] = []
    var nextFrom: String?
    
    init() {
        
    }
    
    init(items: [NewsFeedElement], profiles: [Profile], groups: [Group], nextFrom: String?) {
        self.items = items
        self.profiles = profiles
        self.groups = groups
        self.nextFrom = nextFrom
    }
    
}


