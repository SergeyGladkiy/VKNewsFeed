//
//  MapperProtocolNewsFeedElement.swift
//  VKNewsFeed
//
//  Created by Serg on 01/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol MapperProtocolNewsFeedElement {
    func getElements(of item: FeedResponse) -> NewsFeedData
}
