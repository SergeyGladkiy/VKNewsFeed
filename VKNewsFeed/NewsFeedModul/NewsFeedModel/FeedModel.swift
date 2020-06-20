//
//  FeedModel.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class FeedModel {
    
    var models = Observable<NewsFeedData>(observable: NewsFeedData())
    
    private var persistentService: PersistentServiceProtocol
    private var fetcher: DataFetcher
    private var newPostsFrom: String?
    private var mapper: MapperProtocolNewsFeedElement
    
    private var persistentItems = [NewsPersistentItem]()
    
    init(fetcher: DataFetcher, persistentService: PersistentServiceProtocol, mapper: MapperProtocolNewsFeedElement) {
        self.fetcher = fetcher
        self.persistentService = persistentService
        self.mapper = mapper
        self.persistentService.changesClosure = { type in
            print("type - \(type)")
        }
    }
}

extension FeedModel: FeedModelProtocol {
   
    // MARK: use vk Newsfeed.get without param start_from
    func getNewsFeed() {
//        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feedResponse in
//            guard let feedResponse = feedResponse else { return }
//            self?.persistentService.saveTask(items: feedResponse.items) {
//                self?.persistentItems = self?.persistentService.fetchData() ?? []
//                guard let items = self?.persistentItems else { return }
//                print("ебана - \(items.count)")
//                guard let newsFeedData = self?.mapper.getElements(of: feedResponse, and: items) else { return }
//                self?.models.observable = newsFeedData
//            }
//
//        }
        
        newPostsFrom = models.observable.nextFrom
        fetcher.getFeed(nextBatchFrom: newPostsFrom) { [weak self] feedResponse in
            guard let self = self else { return }
            
            guard let feedResponse = feedResponse, self.models.observable.nextFrom != feedResponse.nextFrom else { return }
            
            self.persistentService.saveTask(items: feedResponse.items) {
                self.persistentItems = self.persistentService.fetchData()
                let items = self.persistentItems
                let newsFeedData = self.mapper.getElements(of: feedResponse, and: items)
                
                if self.newPostsFrom == nil {
                    self.models.observable = newsFeedData
                } else {
                    self.models.observable = self.settingNewBatchPost(from: newsFeedData)
                }
            }
        }
        
        fetcher.getConversations(response: { (response) in
            print("messages created with items - \(String(describing: response?.items))")
        })
        
        fetcher.getLongPollServer { (response) in
            print("server longPoll equal - \(String(describing: response?.server))")
        }
    }
    
    private func settingNewBatchPost(from newData: NewsFeedData) -> NewsFeedData {
        var items = self.models.observable.items
        items.append(contentsOf: newData.items)
        
        let nextFrom = newData.nextFrom
        
        var profiles = newData.profiles
        let oldProfiles = self.models.observable.profiles
        let oldProfilesFiltered = oldProfiles.filter({ oldProfile in
            !newData.profiles.contains(where: { $0.id == oldProfile.id })
        })
        profiles.append(contentsOf: oldProfilesFiltered)
        
        var groups = newData.groups
        let oldGroups = self.models.observable.groups
        let oldGroupsFiltered = oldGroups.filter({ oldGroup in
            !newData.groups.contains(where: { $0.id == oldGroup.id })
        })
        groups.append(contentsOf: oldGroupsFiltered)
        
        return NewsFeedData(items: items, profiles: profiles, groups: groups, nextFrom: nextFrom)
    }
    
    // MARK: use vk Newsfeed.get with param start_from
    func getNewPosts() {
        newPostsFrom = models.observable.nextFrom
        fetcher.getFeed(nextBatchFrom: newPostsFrom) { [weak self] feedResponse in
            guard let self = self else { return }
            
            guard let feedResponse = feedResponse, self.models.observable.nextFrom != feedResponse.nextFrom else { return }
            
            self.persistentService.saveTask(items: feedResponse.items) {
                self.persistentItems = self.persistentService.fetchData()
                let items = self.persistentItems
                let newsFeedData = self.mapper.getElements(of: feedResponse, and: items)
                print("newPostFrom - \(String(describing: self.newPostsFrom)), came nextFrom from net - \(String(describing: newsFeedData.nextFrom))")
                //self?.models.observable.items.append(contentsOf: newsFeedData.items)
                //self?.models.observable.nextFrom = newsFeedData.nextFrom
                
                var newItems = self.models.observable.items
                newItems.append(contentsOf: newsFeedData.items)
                
                let nextFrom = newsFeedData.nextFrom
                
                var profiles = newsFeedData.profiles
                let oldProfiles = self.models.observable.profiles
                let oldProfilesFiltered = oldProfiles.filter({ oldProfile in
                    !newsFeedData.profiles.contains(where: { $0.id == oldProfile.id })
                })
                
                profiles.append(contentsOf: oldProfilesFiltered)
                
                //self?.models.observable.profiles = profiles
                
                
                var groups = newsFeedData.groups
                let oldGroups = self.models.observable.groups
                let oldGroupsFiltered = oldGroups.filter({ oldGroup in
                    !newsFeedData.groups.contains(where: { $0.id == oldGroup.id })
                })
                groups.append(contentsOf: oldGroupsFiltered)
                //self?.models.observable.groups = groups
                
                //guard let response = self?.models.observable else { return }
                
                
                let response = NewsFeedData(items: newItems, profiles: profiles, groups: groups, nextFrom: nextFrom)
                self.models.observable = response }
        }
    }
}


