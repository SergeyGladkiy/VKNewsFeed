//
//  NewsFeedProfileProtocol.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol NewsFeedProfileProtocol {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct NewsFeedProfile: NewsFeedProfileProtocol {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct NewsFeedGroup: NewsFeedProfileProtocol {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}
