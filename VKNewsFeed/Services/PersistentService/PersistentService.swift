//
//  PersistantService.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import CoreData

class PersistentService {

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsFeedModelItems")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension PersistentService: PersistentServiceProtocol {
    func saveTask(items: [FeedItem]) {
        let context = persistentContainer.viewContext
        
        // есть ли у нас уже записи в core data, чтобы не было перезаписи дефолтными значениями
        let fetchRequest: NSFetchRequest<NewsFeedItem> = NewsFeedItem.fetchRequest()
        //установка критерия
        fetchRequest.predicate = NSPredicate(format: "sourceId != nil")
        
        var records = 0
        
        do {
            let count = try context.count(for: fetchRequest)
            records = count
            print("Data is there already? quantity - \(count)")
        } catch {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        for item in items {
            let entity = NSEntityDescription.entity(forEntityName: "NewsFeedItem", in: context)
            let newsFeedItem = NSManagedObject(entity: entity!, insertInto: context) as! NewsFeedItem

            newsFeedItem.sourceId = Int64((item.sourceId))
            newsFeedItem.postId = Int64(item.postId)
            newsFeedItem.text = item.text
            newsFeedItem.date = item.date
            guard let commets = item.comments?.count else { return }
            newsFeedItem.comments = Int64(commets)
            newsFeedItem.likes = Int64((item.likes?.count)!)
            newsFeedItem.reposts = Int64((item.reposts?.count)!)
            newsFeedItem.views = Int64((item.views?.count)!)
        
        }
        do {
            try context.save()
            print("Saved!")
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
