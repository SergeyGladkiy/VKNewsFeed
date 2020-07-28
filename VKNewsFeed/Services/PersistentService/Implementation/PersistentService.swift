//
//  PersistantService.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import CoreData


class PersistentService: NSObject {
    
    private let persistentContainer: NSPersistentContainer
    private let mapper: PersistentServiceEntitiesMapperProtocol
    
    private var changesClosureStored: ((DatabaseItemsChageType<NewsPersistentItem>) -> Void)?
    
    private var controller: NSFetchedResultsController<NewsFeedItem>!
    
    init(mapper: PersistentServiceEntitiesMapperProtocol) {
        self.mapper = mapper
        
        //By default, the provided name value is used to name the persistent store and is used to look up the name of the NSManagedObjectModel object to be used with the NSPersistentContainer object.
        persistentContainer = NSPersistentContainer(name: "NewsFeedModelItems")
        super.init()
        
        //????!!!!!
        //or let privateMOC = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        //privateMOC.parentContext = moc
        
        persistentContainer.loadPersistentStores {[weak self] desc, error in
            guard let error = error else {
                self?.makeFetchResultContorller()
                self?.controller.delegate = self
                return
            }
            print("Persistent Container error: " + error.localizedDescription)
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
    }
    
    private func makeFetchResultContorller() {
        let fetchRequest = NSFetchRequest<NewsFeedItem>(entityName: "NewsFeedItem")
        // Configure the request's entity, and optionally its predicate
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try controller.performFetch()
            self.controller = controller
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
}

extension PersistentService: PersistentServiceProtocol {
    
    private func deleteData() {
        do {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsFeedItem")
            do {
                let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map {$0.map{context.delete($0)}}
                try context.save()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    var changesClosure: (DatabaseItemsChageType<NewsPersistentItem>) -> Void {
        get {
            return changesClosureStored!
        }
        set {
            changesClosureStored = newValue
        }
    }
    
    func saveTask(items: [FeedItem], completion: @escaping () -> Void) {
        deleteData()
        persistentContainer.performBackgroundTask { (context) in
            /*
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
            
            guard records == 0 else { return } */
            let persistentItems = self.mapper.persistentItems(fromItems: items)
            _ = self.mapper.entities(fromItems: persistentItems, in: context)
            do {
                try context.save()
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() -> [NewsPersistentItem] {
        let request = NSFetchRequest<NewsFeedItem>(entityName: "NewsFeedItem")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        let context = persistentContainer.newBackgroundContext()

        do {
            let result = try context.fetch(request)
            
            return mapper.items(fromEntities: result)
            
//            return result.map {
//                let array = $0.newsToAttach?.allObjects as? [Attachment]
//
//                var castArray = [AttechmentPersistentItem]()
//
//                array?.forEach({ (attach) in
//                    let castAttach = AttechmentPersistentItem(url: attach.url ?? "", width: attach.width, height: attach.height)
//                    castArray.append(castAttach)
//
//                })
//
//                return NewsPersistentItem(sourceId: Int($0.sourceId),
//                                             postId: Int($0.postId),
//                                             text: $0.text,
//                                             date: $0.date,
//                                             comments: Int($0.comments),
//                                             likes: Int($0.likes),
//                                             reposts: Int($0.reposts),
//                                             views: Int($0.views),
//                                             attachments: castArray) }
        } catch {
            print("Fetching data Failed, \(error.localizedDescription)")
        }
        return []
    }
    
}

extension PersistentService: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        guard let entity = anObject as? NewsFeedItem else { return }
        let objects = mapper.items(fromEntities: [entity])
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            changesClosureStored?(.deleted(items: objects, indexPaths: [indexPath]))
        case .insert:
            guard let indexPath = indexPath else { return }
            changesClosureStored?(.inserted(items: objects, indexPaths: [indexPath]))
        case .move:
            guard let oldIndex = indexPath, let newIndex = newIndexPath else { return }
            changesClosureStored?(.moved(items: objects, fromIndexPaths: [oldIndex], toIndexPaths: [newIndex]))
        case .update:
            guard let indexPath = indexPath else { return }
            changesClosureStored?(.changed(items: objects, indexPaths: [indexPath]))
        @unknown default:
            fatalError()
        }
    }
}
