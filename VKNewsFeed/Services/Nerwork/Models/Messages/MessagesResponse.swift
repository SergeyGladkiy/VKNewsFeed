//
//  MessagesResponseWrapped.swift
//  VKNewsFeed
//
//  Created by Serg on 15/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class MessagesResponseWrapped: Decodable {
    let response: MessagesResponse
}

class MessagesResponse: Decodable {
    var count: Int
    var items: [MessagesItem]
    var unreadCount: Int
    var profiles: [ProfileMessages]
    var groups: [GroupMessages]
}


