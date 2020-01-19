//
//  UserAttachments.swift
//  VKNewsFeed
//
//  Created by Serg on 19/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct UserPhoto: Decodable {
    let id: String
    let url: String
    let processedFiles: [UserProcessedFiles]
}

struct UserProcessedFiles: Decodable {
    let url: String
    let width: Int
    let height: Int
}
