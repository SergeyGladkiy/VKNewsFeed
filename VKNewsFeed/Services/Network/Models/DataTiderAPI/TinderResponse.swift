//
//  TinderResponse.swift
//  VKNewsFeed
//
//  Created by Serg on 19/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation


struct TinderResponseWrapped: Decodable {
    let data: DataTinder
}

struct DataTinder: Decodable {
    let results: [UserResult]
}








