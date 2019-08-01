//
//  DependenceProvider.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import Swinject

class DependenceProvider {
    private static let assembler = Assembler([AuthServiceAssembly(),
                                              ApplicationCoordinatorAssembly(),
                                              NewsfeedAssembly(),
                                              NetworkingAssembly(),
                                              AuthServiceAssembly(),
                                              PersistentServiceAssembly()])
    
    static func resolve<T>() -> T {
        return assembler.resolver.resolve(T.self)!
    }
}
