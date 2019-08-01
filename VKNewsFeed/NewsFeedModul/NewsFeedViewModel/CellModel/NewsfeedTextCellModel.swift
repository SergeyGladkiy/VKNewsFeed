//
//  NewsfeedTextCellModel.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsfeedTextCellModel: ItemTableCellModel {
    static var reuseIdentifier: String = PostTextNewsfeedCell.reuseIdentifier
    
    let text: String?
    
    init(postText: String?) {
        self.text = postText
    }
}
