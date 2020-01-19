//
//  LongPollResponse.swift
//  VKNewsFeed
//
//  Created by Serg on 16/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class ConnectionDataLongPollWrapped: Decodable {
    let response: ConnectionDataLongPollServer
}

class ConnectionDataLongPollServer: Decodable {
    var key: String
    var server: String
    var ts: Int
}
