//
//  Attachments.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

struct Attechment: Decodable {
    let photo: Photo?
}

struct PhotoAttachment {
    var url: String
    var height: Int
    var width: Int
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getProperSize().height
    }
    
    var width: Int {
        return getProperSize().width
    }
    
    var srcBIG: String {
        return getProperSize().url
    }
    
    private func getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
