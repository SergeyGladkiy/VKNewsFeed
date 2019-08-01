//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Serg on 19/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    private var downoloadManager: ImageDownloadManager {
        return ImageDownloadManager.instance
    }
    
    func set(imageURL: String) {
        downoloadManager.setImage(toImageView: self, urlString: imageURL)
    }
}
