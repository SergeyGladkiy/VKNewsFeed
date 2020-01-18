//
//  CreateChat.swift
//  VKNewsFeed
//
//  Created by Serg on 15/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct MessagesItem: Decodable {
    let conversationItem: ConversationItem
    let lastMessageItem: LastMessageItem
}


struct ConversationItem: Decodable {
    let peer: Peer
    let inRead: Int
    let outRead: Int
    let unreadCount: Int
}

struct Peer: Decodable {
    let id: Int
    let type: String
    let localId: Int
}

struct LastMessageItem: Decodable {
    let id: Int
    let date: Int
    let peerId: Int
    let fromId: Int
    let text: String
    
}

class Chat: Decodable {
    var chatId: Int
}
