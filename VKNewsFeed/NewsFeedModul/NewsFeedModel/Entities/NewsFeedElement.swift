//
//  NewsFeedElement.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsFeedElement {
    
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: Observable<Int?>
    let likes: Observable<Int?>
    let reposts: Observable<Int?>
    let views: Observable<Int?>
    let attachments: [AttechmentPersistentItem]?
    
    init(sourceId: Int, postId: Int, text: String?, date: Double, comments: Observable<Int?>, likes: Observable<Int?>, reposts: Observable<Int?>, views: Observable<Int?>, attachments: [AttechmentPersistentItem]) {
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
