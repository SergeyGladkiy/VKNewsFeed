//
//  NetworkingAssembly.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class NetworkingAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Networking.self) {  r in
            let authService = r.resolve(AuthServiceProtocol.self)!
            return NetworkService(authService: authService)
        }
        
        container.register(DataFetcher.self) { resolver in
            let networking = resolver.resolve(Networking.self)!
            return NetworkDataFetcher(networking: networking)
        }
    }
}
