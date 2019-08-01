//
//  AuthServiceProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    var token: String? { get }
    var delegate: AuthServiceDelegate? { get set }

    func wakeUpSeccion()
}
