//
//  FeedViewModel.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

enum FeedViewModelState {
    case initial
    case readyShowItems(Int, Int)
    case showLoader
}

class FeedViewModel {
    
    var readyNewsFeedItems = Observable<[Int: [ItemTableCellModel]]>(observable: [:])
    
    var state: Observable<FeedViewModelState>
    
    private var firstIndex = 0
    
    private var firstCallfetchNewsFeed = false
    
    private var timer: RepeatingTimerProtocol
    
    private let model: FeedModelProtocol
    private let mapper: MapperProtocolItemsTableCellModel
    
    init(model: FeedModelProtocol, state: Observable<FeedViewModelState>, mapper: MapperProtocolItemsTableCellModel, timer: RepeatingTimerProtocol) {
        
        self.model = model
        self.state = state
        self.mapper = mapper
        self.timer = timer
        
        model.models.bind { [weak self] response in
            guard let self = self else { return }
            self.timer.suspend()
            self.readyNewsFeedItems.observable = self.mapper.buildNewsFeedItems(items: response.items, profiles: response.profiles, groups: response.groups)
            if self.firstCallfetchNewsFeed == true {
                self.state.observable = .readyShowItems(0, 49)
                print("firstIndex \(self.firstIndex) secondIndex \(self.readyNewsFeedItems.observable.count-1)")
                self.firstIndex = self.readyNewsFeedItems.observable.count
            } else {
                self.state.observable = .readyShowItems(self.firstIndex, self.readyNewsFeedItems.observable.count-1)
                print("firstIndex \(self.firstIndex) secondIndex \(self.readyNewsFeedItems.observable.count-1)")
                self.firstIndex = self.readyNewsFeedItems.observable.count
            }
            
        }
    } // add state errors
}

extension FeedViewModel: FeedViewModelProtocol {
    
    func numberOfSection() -> Int {
        return readyNewsFeedItems.observable.count
    }
    
    func numberOfRows(section: Int) -> Int {
        guard let numberOfRows = readyNewsFeedItems.observable[section]?.count else { return 0 }
        return numberOfRows
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ItemTableCellModel? {
        return readyNewsFeedItems.observable[indexPath.section]?[indexPath.row]
        
    }
    
    func fetchNewsFeed() {
        firstCallfetchNewsFeed = true
        model.getNewsFeed()
    }
    
    func getNewData() {
        firstCallfetchNewsFeed = false
        model.getNewPosts()
        timer.eventHandler = { [weak self] in
            self?.timer.suspend()
            self?.state.observable = .showLoader
        }
        timer.resume()
    }
}
