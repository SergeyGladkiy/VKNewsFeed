//
//  UserResult.swift
//  VKNewsFeed
//
//  Created by Serg on 19/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct UserResult: Decodable {
    let user: UserInfo
    let distanceMi: Int
    let teaser: UserTeaser
    let teasers: [UserTeaser]
}
