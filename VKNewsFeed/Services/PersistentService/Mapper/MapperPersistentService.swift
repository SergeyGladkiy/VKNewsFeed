//
//  File.swift
//  VKNewsFeed
//
//  Created by Serg on 08/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import CoreData

class MapperPresistentService: PersistentServiceEntitiesMapperProtocol {
    func persistentItems(fromItems networkData: [FeedItem]) -> [NewsPersistentItem] {
        return networkData.map {
            let photoAttach = $0.attachments?.filter({ (attach) -> Bool in
                return attach.photo != nil
            })
            

            var arrayAttach = [AttechmentPersistentItem]()
            
            let _ = photoAttach?.forEach({ (attach) in
                guard let width = attach.photo?.width,
                    let height = attach.photo?.height else { return }
                let attach = AttechmentPersistentItem(url: attach.photo?.srcBIG ?? "", width: Float(width), height: Float(height))
                arrayAttach.append(attach)
            })
            
            return NewsPersistentItem(sourceId: $0.sourceId, postId: $0.postId, text: $0.text, date: $0.date, comments: $0.comments?.count, likes: $0.likes?.count, reposts: $0.reposts?.count, views: $0.views?.count, attachments: arrayAttach)
            
        }
    }
    
    func entities(fromItems: [NewsPersistentItem], in context: NSManagedObjectContext) -> [NewsFeedItem] {
        let items = fromItems.compactMap { item -> NewsFeedItem? in
            let entity = NSEntityDescription.entity(forEntityName: "NewsFeedItem", in: context)
            let newsFeedItem = NSManagedObject(entity: entity!, insertInto: context) as! NewsFeedItem
            
            
            newsFeedItem.sourceId = Int64(item.sourceId)
            newsFeedItem.postId = Int64(item.postId)
            newsFeedItem.text = item.text
            newsFeedItem.date = item.date
            guard let comments = item.comments,
                let likes = item.likes,
                let reposts = item.reposts,
                let views = item.views else { return nil }
            newsFeedItem.comments = Int64(comments)
            newsFeedItem.likes = Int64(likes)
            newsFeedItem.reposts = Int64(reposts)
            newsFeedItem.views = Int64(views)
            
            //Преобразовать вот тут модель аттачей в NSSet
            let attachments = NSMutableSet()
            item.attachments.forEach({ (attch) in
                guard let entity = NSEntityDescription.entity(forEntityName: "Attachment", in: context) else { return }
                let attachment = NSManagedObject(entity: entity, insertInto: context) as! Attachment
                attachment.height = attch.height
                attachment.width = attch.width
                attachment.url = attch.url
                attachment.attachToNews = newsFeedItem
                attachments.add(attachment)
            })
            newsFeedItem.addToNewsToAttach(attachments)
            return newsFeedItem
        }
        return items
    }
    
    func items(fromEntities: [NewsFeedItem]) -> [NewsPersistentItem] {
        return fromEntities.map { NewsPersistentItem(sourceId: Int($0.sourceId),
                                               postId: Int($0.postId),
                                               text: $0.text,
                                               date: $0.date,
                                               comments: Int($0.comments),
                                               likes: Int($0.likes),
                                               reposts: Int($0.reposts),
                                               views: Int($0.views),
                                               attachments: [])}
    }
}
