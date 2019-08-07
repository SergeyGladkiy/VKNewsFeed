//
//  NewsfeedPhotosCellModel.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedPhotoCellModel: ItemTableCellModel {
    static var reuseIdentifier: String = PhotoNewsfeedCell.reuseIdentifier
    
    let attachments: [PhotoAttachment]
    var height: CGFloat = 0
    var width: CGFloat = UIScreen.main.bounds.width
    
    init(photo: [PhotoAttachment], ratio: Double) {
        self.attachments = photo
        self.height = width * CGFloat(ratio)
    }
}
