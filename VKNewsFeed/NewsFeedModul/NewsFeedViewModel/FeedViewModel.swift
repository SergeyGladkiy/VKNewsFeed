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
    
    var readyNewsFeedItems = [Int: [ItemTableCellModel]]()
    
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
            self.readyNewsFeedItems = self.mapper.buildNewsFeedItems(items: response.items, profiles: response.profiles, groups: response.groups)
            if self.firstCallfetchNewsFeed == true {
                self.state.observable = .readyShowItems(0, 49)
                print("firstIndex \(self.firstIndex) secondIndex \(self.readyNewsFeedItems.count-1)")
                self.firstIndex = self.readyNewsFeedItems.count
            } else {
                self.state.observable = .readyShowItems(self.firstIndex, self.readyNewsFeedItems.count-1)
                print("firstIndex \(self.firstIndex) secondIndex \(self.readyNewsFeedItems.count-1)")
                self.firstIndex = self.readyNewsFeedItems.count
            }
            
        }
    } // add state errors
}

extension FeedViewModel: FeedViewModelProtocol {
    
    func numberOfSection() -> Int {
        return readyNewsFeedItems.count
    }
    
    func numberOfRows(section: Int) -> Int {
        guard let numberOfRows = readyNewsFeedItems[section]?.count else { return 0 }
        return numberOfRows
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ItemTableCellModel? {
        return readyNewsFeedItems[indexPath.section]?[indexPath.row]
        
    }
    
    func fetchNewsFeed() {
        firstCallfetchNewsFeed = true
        model.getNewsFeed()
        settingTimer()
    }
    
    func getNewData() {
        firstCallfetchNewsFeed = false
        //model.getNewPosts()
        model.getNewsFeed()
        settingTimer()
    }
    
    private func settingTimer() {
        timer.eventHandler = { [weak self] in
            print("thread from dispatch timer\(qos_class_self())")
            self?.timer.suspend()
            
            self?.state.observable = .showLoader
        }
        timer.resume()
    }
}
