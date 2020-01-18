//
//  UserTeaser.swift
//  VKNewsFeed
//
//  Created by Serg on 19/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct UserTeaser: Decodable {
    let type: String?
    let string: String
}

struct UserJob: Decodable {
    let company: CompanyJob?
    let title: TitleJob?
}

struct UserSchool: Decodable {
    let name: String?
}

struct CompanyJob: Decodable {
    let name: String
}

struct TitleJob: Decodable {
    let name: String
}
