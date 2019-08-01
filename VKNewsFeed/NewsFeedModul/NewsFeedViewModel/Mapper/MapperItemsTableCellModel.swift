//
//  MapperFeedModel.swift
//  VKNewsFeed
//
//  Created by Serg on 11/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

final class MapperItemsTableCellModel {
   
    private func buildNewsfeedHeaderCellModel(item: FeedItem, profile: ProfileRepresentable) -> ItemTableCellModel {
        let date = getPostDate(date: item.date)
        return NewsfeedHeaderCellModel(userName: profile.name,
                                       date: date,
                                       imageURL: profile.photo)
    }
    
    private func buildNewsfeedTextCellModel(item: FeedItem) -> ItemTableCellModel {
        return NewsfeedTextCellModel(postText: item.text)
    }
    
    private func buildNewsfeedPhotoCellModel(attachments: [PhotoAttachment]) -> ItemTableCellModel {
        let maxHeight = attachments.map { $0.height }.max()
        let item = attachments.first(where: {
            $0.height == maxHeight
        })
        let ration = maxHeight! / item!.width
        return NewsfeedPhotoCellModel(photo: attachments, ratio: ration)
    }
    
    private func buildNewsfeedFooterCellModel(item: FeedItem) -> ItemTableCellModel {
        let likes = item.likes?.count ?? 0
        let comments = item.comments?.count ?? 0
        let reposts = item.reposts?.count ?? 0
        let viewers = item.views?.count ?? 0
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
    
    private func getAttachments(item: FeedItem) -> [PhotoAttachment] {
        guard let attachments = item.attachments else {
            return []
        }
        
        return attachments.compactMap({ attachment  in
            guard let photo = attachment.photo else {
                return nil
            }
            
            return PhotoAttachment(url: photo.srcBIG, height: photo.height, width: photo.width)
        })
    }
}

extension MapperItemsTableCellModel: MapperProtocolItemsTableCellModel {
    
    
    func buildNewsFeedItems(items: [FeedItem], profiles: [Profile], groups: [Group]) -> [ItemTableCellModel] {
        
        var cellModels = [ItemTableCellModel]()
        for item in items {
            guard let userProfile = getUserProfiles(for: item.sourceId, profiles: profiles, groups: groups) else {
                return cellModels
            }
            let header = buildNewsfeedHeaderCellModel(item: item, profile: userProfile)
            cellModels.append(header)
            if item.text != "" {
                let post = buildNewsfeedTextCellModel(item: item)
                cellModels.append(post)
            }
            let attachments = getAttachments(item: item)
            if !attachments.isEmpty {
                let photos = buildNewsfeedPhotoCellModel(attachments: attachments)
                cellModels.append(photos)
            }
            let actions = buildNewsfeedFooterCellModel(item: item)
            cellModels.append(actions)
        }
        return cellModels
    }
}

