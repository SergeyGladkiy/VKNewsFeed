//
//  AuthAssembly.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class AuthServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthServiceProtocol.self) { _ in AuthService()}.inObjectScope(.container)
    }
}
