//
//  PersistentItem.swift
//  VKNewsFeed
//
//  Created by Serg on 08/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsPersistentItem {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: Int?
    let likes: Int?
    let reposts: Int?
    let views: Int?
    let attachments: [AttechmentPersistentItem]
    
    init(sourceId: Int, postId: Int, text: String?, date: Double, comments: Int?, likes: Int?, reposts: Int?, views: Int?, attachments: [AttechmentPersistentItem]) {
        self.sourceId = sourceId
        self.postId = postId
        self.text = text
        self.date = date
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.views = views
        self.attachments = attachments
    }
}

struct AttechmentPersistentItem {
    
    let url: String
    let width: Float
    let height: Float
}
