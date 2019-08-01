//
//  TableViewCellViewModel.swift
//  VKNewsFeed
//
//  Created by Serg on 11/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class TableViewCellViewModel {
    
    var iconUrlString: String
    var name: String
    var date: String
    var text: String
    var likes: String
    var comments: String
    var shares: String
    var views: String
    
    init(model: ItemNewsfeed) {
        self.iconUrlString = model.iconUrlString
        self.name = model.name
        self.date = model.date
        self.text = model.text
        self.likes = model.likes
        self.shares = model.shares
        self.comments = model.comments
        self.views = model.views
    }
}
