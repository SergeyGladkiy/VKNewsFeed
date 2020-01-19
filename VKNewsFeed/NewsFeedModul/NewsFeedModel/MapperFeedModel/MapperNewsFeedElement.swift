//
//  MapperNewsFeedElement.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MapperNewsFeedElement {
    
}

extension MapperNewsFeedElement: MapperProtocolNewsFeedElement {
    
    func getElements(of item: FeedResponse, and persistentItem: [NewsPersistentItem]) -> NewsFeedData {
        let elementsNewsFeed = persistentItem.map { NewsFeedElement(sourceId: $0.sourceId, postId: $0.postId, text: $0.text, date: $0.date, comments: Observable(observable: $0.comments), likes: Observable(observable: $0.likes), reposts: Observable(observable: $0.reposts), views: Observable(observable: $0.views), attachments: $0.attachments)
        }
    
        return NewsFeedData(items: elementsNewsFeed, profiles: item.profiles, groups: item.groups, nextFrom: item.nextFrom)
    }
}
