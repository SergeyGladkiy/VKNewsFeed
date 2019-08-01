//
//  FeedModel.swift
//  VKNewsFeed
//
//  Created by Serg on 08/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class FeedModel {
    
    var models = Observable<FeedResponse>(observable: FeedResponse())
    
    private var persistantService: PersistantService
    private var fetcher: DataFetcher
    private var newPostsFrom: String?
    
    init(fetcher: DataFetcher, persistantService: PersistantService) {
        self.fetcher = fetcher
        self.persistantService = persistantService
        
    }
}

extension FeedModel: FeedModelProtocol {
   
    
    // MARK: use vk Newsfeed.get without param start_from
    func getNewsFeed() {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feedResponse in
            guard let feedResponse = feedResponse else { return }
            self?.models.observable = feedResponse

        }
    }
    
    // MARK: use vk Newsfeed.get with param start_from
    func getNewPosts() {
        newPostsFrom = models.observable.nextFrom
        fetcher.getFeed(nextBatchFrom: newPostsFrom) { [weak self] feedResponse in
            guard let feedResponse = feedResponse, self?.models.observable.nextFrom != feedResponse.nextFrom else { return }
            
            self?.models.observable.items.append(contentsOf: feedResponse.items)
            print("my nextFrom \(self?.models.observable.nextFrom) and response nextFrom \(feedResponse.nextFrom)")
            self?.models.observable.nextFrom = feedResponse.nextFrom
            
            
            
            var profiles = feedResponse.profiles
            if let oldProfiles = self?.models.observable.profiles {
                let oldProfilesFiltered = oldProfiles.filter({ oldProfile in
                    !feedResponse.profiles.contains(where: { $0.id == oldProfile.id })
                })
                profiles.append(contentsOf: oldProfilesFiltered)
            }
            self?.models.observable.profiles = profiles
            
            
            var groups = feedResponse.groups
            if let oldGroups = self?.models.observable.groups {
                let oldGroupsFiltered = oldGroups.filter({ oldGroup in
                    !feedResponse.groups.contains(where: { $0.id == oldGroup.id })
                })
                groups.append(contentsOf: oldGroupsFiltered)
                print(groups)
            }
            self?.models.observable.groups = groups
            
            guard let response = self?.models.observable else { return }
            self?.models.observable = response
            //completion(response)
        }
    }
    
    func saveTask(items: [FeedItem]) {
        persistantService.saveTask(items: items)
    }
}


