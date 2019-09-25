//
//  ProfileMessagesRepresentable.swift
//  VKNewsFeed
//
//  Created by Serg on 16/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol ProfileMessagesRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct ProfileMessages: Decodable, ProfileMessagesRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let cropPhoto: CropPhoto?
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return cropPhoto?.photo.srcBIG ?? "" }
}



struct GroupMessages: Decodable, ProfileMessagesRepresentable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}
