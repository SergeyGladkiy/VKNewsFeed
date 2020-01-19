//
//  PersistentServiceEntitiesMapperProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 08/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import CoreData

protocol PersistentServiceEntitiesMapperProtocol {
    func persistentItems(fromItems networkData: [FeedItem]) -> [NewsPersistentItem]
    func entities(fromItems: [NewsPersistentItem], in context: NSManagedObjectContext) -> [NewsFeedItem]
    func items(fromEntities: [NewsFeedItem]) -> [NewsPersistentItem]
}
