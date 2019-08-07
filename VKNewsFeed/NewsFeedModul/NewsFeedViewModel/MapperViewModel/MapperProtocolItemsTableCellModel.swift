//
//  MapperFeedModelProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 11/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MapperProtocolItemsTableCellModel {
    func buildNewsFeedItems(items: [NewsFeedElement], profiles: [Profile], groups: [Group]) -> [Int: [ItemTableCellModel]]
}
