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
    case readyShowItems//([IndexPath])
    case newItemsReceived
}

class FeedViewModel {
    
    var readyNewsFeedItems = Observable<[ItemTableCellModel]>(observable: [])
    
    var state: Observable<FeedViewModelState>
    
    private var arrayIndexPath = [IndexPath]()
    
    private lazy var dispatchSourceTimer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + 0.5)
        timer.setEventHandler(handler: { [weak self] in
            self?.getNewData()
            self?.fetchNewsFeed()
        })
        return timer
    }()
    
    private let model: FeedModelProtocol
    private let mapper: MapperProtocolItemsTableCellModel
    
    init(model: FeedModelProtocol, state: Observable<FeedViewModelState>, mapper: MapperProtocolItemsTableCellModel) {
        self.model = model
        self.state = state
        self.mapper = mapper
    } // add state errors
}

extension FeedViewModel: FeedViewModelProtocol {
    
    func twoWayDataBinding() {
        model.models.bind { [weak self] response in
            guard let self = self else { return }
            self.readyNewsFeedItems.observable = self.mapper.buildNewsFeedItems(items: response.items, profiles: response.profiles, groups: response.groups)
            
            //print("/? \(self.readyNewsFeedItems.observable.)")
//            switch response.items.count {
//            case 50:
//                let section = 0
//                let indexes = response.items.enumerated()
//                self.arrayIndexPath = indexes.map { IndexPath(row: $0.offset, section: section)}
//            case 100:
//                let section = 1
//                let indexes = response.items.enumerated()
//                self.arrayIndexPath = indexes.map { IndexPath(row: $0.offset, section: section)}
//            default:
//                print(self.readyNewsFeedItems.observable.count)
//            }
            self.state.observable = .readyShowItems//(self.arrayIndexPath)
            
            
        } // add errors
    }
    
    func numberOfRows() -> Int {
        return readyNewsFeedItems.observable.count 
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ItemTableCellModel? {
        return readyNewsFeedItems.observable[indexPath.row]
        
    }
    
    func fetchNewsFeed() {
        model.getNewsFeed()
    }
    
    func getNewData() {
        model.getNewPosts()
    }
}
