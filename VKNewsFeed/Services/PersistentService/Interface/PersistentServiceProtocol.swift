//
//  PersistantServiceProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol PersistentServiceProtocol {
    var changesClosure: (DatabaseItemsChageType<NewsPersistentItem>) -> Void {get set}
    
    func saveTask(items: [FeedItem], completion: @escaping () -> Void)
    func fetchData() -> [NewsPersistentItem]
}
