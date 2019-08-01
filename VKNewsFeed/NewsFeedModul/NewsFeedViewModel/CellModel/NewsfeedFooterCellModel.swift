//
//  NewsfeedFooterCellModel.swift
//  VKNewsFeed
//
//  Created by Serg on 24/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NewsfeedFooterCellModel: ItemTableCellModel {
    static var reuseIdentifier: String = FooterNewsfeedCell.reuseIdentifier
    
    var like: String
    var comment: String
    var share: String
    var viewers: String
    
    init(likeCount: Int, commentCount: Int, shareCount: Int, viewersCount: Int) {
        self.like = String(likeCount)
        self.comment = String(commentCount)
        self.share = String(shareCount)
        self.viewers = String(viewersCount)
        self.like = formattedCounter(likeCount) ?? "0"
        self.comment = formattedCounter(commentCount) ?? "0"
        self.share = formattedCounter(shareCount) ?? "0"
        self.viewers = formattedCounter(viewersCount) ?? "0"
    }
    
//    private func makeIntToString(_ value: Int) -> String {
//        if value / 1000 >= 1 {
//            return String(value / 1000) + "K"
//        } else {
//            return String(value)
//        }
//    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
}
