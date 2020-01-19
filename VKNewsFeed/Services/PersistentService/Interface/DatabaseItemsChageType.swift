//
//  DatabaseItemsChageType.swift
//  VKNewsFeed
//
//  Created by Serg on 08/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum DatabaseItemsChageType<T> {
    case inserted(items: [T], indexPaths: [IndexPath])
    case deleted(items: [T], indexPaths: [IndexPath])
    case changed(items: [T], indexPaths: [IndexPath])
    case moved(items: [T], fromIndexPaths: [IndexPath], toIndexPaths: [IndexPath])
}
