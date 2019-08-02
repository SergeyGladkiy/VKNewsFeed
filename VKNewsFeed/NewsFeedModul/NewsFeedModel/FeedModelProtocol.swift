//
//  FeedModelProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 17/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol FeedModelProtocol {
    var models: Observable<NewsFeedData> { get }
    
    func getNewsFeed()
    func getNewPosts()
}
