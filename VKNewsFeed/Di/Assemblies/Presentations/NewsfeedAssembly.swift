//
//  NewsfeedAssembly.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class NewsfeedAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(ProtocolCoordinatorAuth.self) { _ in
            CoordinatorAuth()
        }
        
        container.register(FeedViewModelProtocol.self) { r in
            let model = r.resolve(FeedModelProtocol.self)!
            let mapper = r.resolve(MapperProtocolItemsTableCellModel.self)!
            return FeedViewModel(model: model, state: .init(observable: .initial), mapper: mapper)
        }
        
        container.register(MapperProtocolItemsTableCellModel.self) { _ in
            MapperItemsTableCellModel()
        }
        
        container.register(FeedModelProtocol.self) { r in
            let persistentService = r.resolve(PersistentServiceProtocol.self)!
            let fetcher = r.resolve(DataFetcher.self)!
            let mapper = r.resolve(MapperProtocolNewsFeedElement.self)!
            return FeedModel(fetcher: fetcher, persistantService: persistentService, mapper: mapper)
        }
        
        container.register(MapperProtocolNewsFeedElement.self) { _ in
            MapperNewsFeedElement()
        }
    }
}
