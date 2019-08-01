//
//  ApplicationCoordinator.swift
//  VKNewsFeed
//
//  Created by Serg on 16/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
    private var window: UIWindow?
    private var coordinatorVKEnter: ProtocolCoordinatorAuth?
}

extension ApplicationCoordinator: Coordinator {
    func prepareWindow() -> UIWindow? {
        coordinatorVKEnter = CoordinatorAuth()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinatorVKEnter!.start()
        window?.makeKeyAndVisible()
        return window
    }
}
