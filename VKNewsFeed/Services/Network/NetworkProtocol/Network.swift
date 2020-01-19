//
//  Network.swift
//  VKNewsFeed
//
//  Created by Serg on 07/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
    func requestLongPollServer(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void)
    
    func requestTinder(path: String, completion: @escaping (Data?, Error?) -> Void)
}
