//
//  AppCoordinatorAssembly.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class ApplicationCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Coordinator.self) { _ in ApplicationCoordinator() }.inObjectScope(.container)
    }
}
