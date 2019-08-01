//
//  NewsFeedViewModelProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol FeedViewModelProtocol {
    var state: Observable<FeedViewModelState> { get }
    var readyNewsFeedItems: Observable<[ItemTableCellModel]> { get }
    
    func getNewData()
    func fetchNewsFeed()
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ItemTableCellModel?
    func numberOfRows() -> Int
}

