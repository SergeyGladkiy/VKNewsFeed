//
//  MapperFeedModel.swift
//  VKNewsFeed
//
//  Created by Serg on 11/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

final class MapperItemsTableCellModel {
   
    private func buildNewsfeedHeaderCellModel(item: NewsFeedElement, profile: ProfileRepresentable) -> ItemTableCellModel {
        let date = getPostDate(date: item.date)
        return NewsfeedHeaderCellModel(userName: profile.name,
                                       date: date,
                                       imageURL: profile.photo)
    }
    
    private func buildNewsfeedTextCellModel(item: NewsFeedElement) -> ItemTableCellModel {
        return NewsfeedTextCellModel(postText: item.text)
    }
    
    private func buildNewsfeedPhotoCellModel(attachments: [PhotoAttachment]) -> ItemTableCellModel {
        let maxAttachments = attachments.max { $0.ratio < $1.ratio }
        guard let ratio = maxAttachments?.ratio else { return NewsfeedPhotoCellModel(photo: [], ratio: 0)}

        return NewsfeedPhotoCellModel(photo: attachments, ratio: ratio)
    }
    
    private func buildNewsfeedFooterCellModel(item: NewsFeedElement) -> ItemTableCellModel {
        let likes = item.likes ?? 0
        let comments = item.comments ?? 0
        let reposts = item.reposts ?? 0
        let viewers = item.views ?? 0
        return NewsfeedFooterCellModel(likeCount: likes,
                                        commentCount: comments,
                                        shareCount: reposts,
                                        viewersCount: viewers)
    }
    
    private func getUserProfiles(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        if sourceId >= 0 {
            return profiles.first { $0.id == sourceId }
        } else {
            return groups.first { $0.id == -sourceId}
        }
    }
    
    private func getPostDate(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    private func getAttachments(item: NewsFeedElement) -> [PhotoAttachment] {
//        guard let attachments = item.attachments else {
//            return []
//        }
        
        return item.attachments.compactMap({ attachment  in
            return PhotoAttachment(url: attachment.url, height: Int(attachment.height), width: Int(attachment.width))
        })
    }
}

extension MapperItemsTableCellModel: MapperProtocolItemsTableCellModel {
    
    
    func buildNewsFeedItems(items: [NewsFeedElement], profiles: [Profile], groups: [Group]) -> [Int: [ItemTableCellModel]] {
        
        var cellModels = [Int: [ItemTableCellModel]]()
        for item in items.enumerated() {
            guard let userProfile = getUserProfiles(for: item.element.sourceId, profiles: profiles, groups: groups) else {
                return cellModels
            }
            let header = buildNewsfeedHeaderCellModel(item: item.element, profile: userProfile)
            cellModels[item.offset] = [ItemTableCellModel]()
            cellModels[item.offset]?.append(header)
            if item.element.text != "" {
                let post = buildNewsfeedTextCellModel(item: item.element)
                cellModels[item.offset]?.append(post)
            }
            let attachments = getAttachments(item: item.element)
            if !attachments.isEmpty {
                let photos = buildNewsfeedPhotoCellModel(attachments: attachments)
                cellModels[item.offset]?.append(photos)
            }
            let actions = buildNewsfeedFooterCellModel(item: item.element)
            cellModels[item.offset]?.append(actions)
        }
        
        return cellModels
    }
}

