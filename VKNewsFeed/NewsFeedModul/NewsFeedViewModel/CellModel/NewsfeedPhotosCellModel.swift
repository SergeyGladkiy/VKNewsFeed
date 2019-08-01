//
//  NewsfeedPhotosCellModel.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsfeedPhotoCellModel: ItemTableCellModel {
    static var reuseIdentifier: String = PhotoNewsfeedCell.reuseIdentifier
    
    let attachments: [PhotoAttachment]
    let ratio: Int
    init(photo: [PhotoAttachment], ratio: Int) {
        self.attachments = photo
        self.ratio = ratio
    }
}
