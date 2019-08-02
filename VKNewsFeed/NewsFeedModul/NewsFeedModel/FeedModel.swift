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
    
    private var persistantService: PersistentServiceProtocol
    private var fetcher: DataFetcher
    private var newPostsFrom: String?
    private var mapper: MapperProtocolNewsFeedElement
    
    init(fetcher: DataFetcher, persistantService: PersistentServiceProtocol, mapper: MapperProtocolNewsFeedElement) {
        self.fetcher = fetcher
        self.persistantService = persistantService
        self.mapper = mapper
    }
}

extension FeedModel: FeedModelProtocol {
   
    func twoWayDataBinding() {
//        models.observable.items.map { $0.comments.bind { [weak self] comments in
//            guard let self = self else { return }
//            }
//        }
    }
    
    // MARK: use vk Newsfeed.get without param start_from
    func getNewsFeed() {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feedResponse in
            guard let feedResponse = feedResponse else { return }
            guard let newsFeedData = self?.mapper.getElements(of: feedResponse) else { return }
            self?.models.observable = newsFeedData

        }
    }
    
    // MARK: use vk Newsfeed.get with param start_from
    func getNewPosts() {
        newPostsFrom = models.observable.nextFrom
        fetcher.getFeed(nextBatchFrom: newPostsFrom) { [weak self] feedResponse in
            guard let feedResponse = feedResponse, self?.models.observable.nextFrom != feedResponse.nextFrom else { return }
             guard let newsFeedData = self?.mapper.getElements(of: feedResponse) else { return }
            self?.models.observable.items.append(contentsOf: newsFeedData.items)
            print("my nextFrom \(self?.models.observable.nextFrom) and response nextFrom \(newsFeedData.nextFrom)")
            self?.models.observable.nextFrom = newsFeedData.nextFrom
            
            
            
            var profiles = newsFeedData.profiles
            if let oldProfiles = self?.models.observable.profiles {
                let oldProfilesFiltered = oldProfiles.filter({ oldProfile in
                    !newsFeedData.profiles.contains(where: { $0.id == oldProfile.id })
                })
                profiles.append(contentsOf: oldProfilesFiltered)
            }
            self?.models.observable.profiles = profiles
            
            
            var groups = newsFeedData.groups
            if let oldGroups = self?.models.observable.groups {
                let oldGroupsFiltered = oldGroups.filter({ oldGroup in
                    !newsFeedData.groups.contains(where: { $0.id == oldGroup.id })
                })
                groups.append(contentsOf: oldGroupsFiltered)
            }
            self?.models.observable.groups = groups
            
            /// -----???---- observable on groups and profile
            guard let response = self?.models.observable else { return }
            self?.models.observable = response
        }
    }
    
    func saveTask(items: [FeedItem]) {
        persistantService.saveTask(items: items)
    }
}


