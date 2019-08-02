//
//  NewsFeedAttachment.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct NewsFeedAttechment {
    let photo: NewsFeedPhoto?
}

struct NewsFeedPhoto {
    let sizes: [NewsFeedPhotoSize]
    var height: Int
    var width: Int
    var srcBIG: String
}

struct NewsFeedPhotoSize {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
