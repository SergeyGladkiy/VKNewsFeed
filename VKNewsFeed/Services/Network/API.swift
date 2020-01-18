//
//  API.swift
//  VKNewsFeed
//
//  Created by Serg on 07/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.101"
    
    static let newsFeed = "/method/newsfeed.get"
    static let messages = "/method/messages.getConversations"
    static let createChat = "/method/messages.createChat"
    static let getLongPoll = "/method/messages.getLongPollServer"
}
