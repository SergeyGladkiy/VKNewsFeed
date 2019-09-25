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

}

extension CoordinatorAuth: ProtocolCoordinatorAuth {
    func start() -> UIViewController {
        var authService: AuthServiceProtocol = DependenceProvider.resolve()
        authService.delegate = self
        let authVC = AuthViewController(authService: authService)
        return authVC
    }
}

extension CoordinatorAuth: AuthServiceDelegate {
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        AppDelegate.shared().window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        let feedViewModel: FeedViewModelProtocol = DependenceProvider.resolve()
        let feedViewController = FeedViewController(viewModel: feedViewModel)
        AppDelegate.shared().window?.rootViewController = feedViewController
    }
    
    func authServiceDidSignInFail() {
        print(#function)
        let alert = UIAlertController(title: "Не удалось подключиться к серверу ", message: "Отсутсвует соединение с интернетом", preferredStyle: .alert)
        let refrashRequestAction = UIAlertAction(title: "Обновить страницу", style: .default) { [weak self] _ in
            guard let self = self else { return }
            var authService: AuthServiceProtocol = DependenceProvider.resolve()
            authService.delegate = self
            let authVC = AuthViewController(authService: authService)
            AppDelegate.shared().window?.rootViewController = authVC
        }
        alert.addAction(refrashRequestAction)
        AppDelegate.shared().window?.rootViewController?.show(alert, sender: nil)
    }
    
    
}
