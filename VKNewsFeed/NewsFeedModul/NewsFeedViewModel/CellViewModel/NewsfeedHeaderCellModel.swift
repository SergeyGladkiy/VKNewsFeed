//
//  NewsfeedHeaderCellModle.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsfeedHeaderCellModel: ItemTableCellModel {
    static let reuseIdentifier: String = HeaderNewsfeedCell.reuseIdentifier
    
    var name: String
    var date: String
    var imageUrl: String
    
    init(userName: String, date: String, imageURL: String) {
        self.name = userName
        self.date = date
        self.imageUrl = imageURL
    }
}

