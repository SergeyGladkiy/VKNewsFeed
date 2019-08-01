//
//  PersistanceAssembly.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class PersistentServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PersistentServiceProtocol.self) { resolver in
            return PersistentService() }.inObjectScope(.container)
    }
}
