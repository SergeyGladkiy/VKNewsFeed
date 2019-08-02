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
    func getElements(of item: FeedResponse) -> NewsFeedData {
        let elementsNewsFeed = item.items.map { NewsFeedElement(sourceId: $0.sourceId, postId: $0.postId, text: $0.text, date: $0.date, comments: Observable(observable: $0.comments?.count), likes: Observable(observable: $0.likes?.count), reposts: Observable(observable: $0.reposts?.count), views: Observable(observable: $0.views?.count), attachments: $0.attachments ?? [Attechment(photo: nil)] )
        }
    
        return NewsFeedData(items: elementsNewsFeed, profiles: item.profiles, groups: item.groups, nextFrom: item.nextFrom)
    }
}
