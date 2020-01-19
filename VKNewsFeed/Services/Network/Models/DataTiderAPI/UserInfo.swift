//
//  UserInfo.swift
//  VKNewsFeed
//
//  Created by Serg on 19/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
    let _id: String
    let bio: String
    let birthDate: String
    let name: String
    let photos: [UserPhoto]
    let gender: Int
    let jobs: [UserJob]
    let schools: [UserSchool]
    let city: UserCity?
}

struct UserCity: Decodable {
    let name: String
}
