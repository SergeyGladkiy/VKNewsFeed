//
//  CollectionViewCellNewsfeed.swift
//  VKNewsFeed
//
//  Created by Serg on 24/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class CollectionViewCellNewsfeed: UICollectionViewCell{
    @IBOutlet weak var photo: UIImageView!
    
    var viewModel: PhotoAttachment? {
        didSet {
            guard let viewModel = viewModel else { return }
            photo.set(imageURL: viewModel.url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
}
