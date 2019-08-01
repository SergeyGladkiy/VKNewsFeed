//
//  File.swift
//  VKNewsFeed
//
//  Created by Serg on 16/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class CoordinatorAuth {
    static let sharedInstance = CoordinatorAuth()
    //var authService = AuthService()
}

extension CoordinatorAuth: ProtocolCoordinatorAuth {
    func start() -> UIViewController {
        //self.authService = AuthService()
//        authService.delegate = self
//        print(authService.delegate)
        let authVC = AuthViewController()
        return authVC
    }
}

extension CoordinatorAuth: AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        AppDelegate.shared().window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        let network = NetworkService()
        let fetcherNetwork = NetworkDataFetcher(networking: network)
        let persistant = PersistantService()
        let mapper = MapperItemsTableCellModel()
        let feedModel = FeedModel(fetcher: fetcherNetwork, persistantService: persistant)
        let feedViewModel = FeedViewModel(model: feedModel, state: .init(observable: .initial), mapper: mapper)
        let feedViewController = FeedViewController(viewModel: feedViewModel)
        feedViewModel.twoWayDataBinding()
        AppDelegate.shared().window?.rootViewController = feedViewController
    }
    
    func authServiceDidSignInFail() {
        print(#function)
    }
    
    
}
