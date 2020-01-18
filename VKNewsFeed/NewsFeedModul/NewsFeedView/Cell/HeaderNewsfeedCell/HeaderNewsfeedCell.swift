//
//  HeaderNewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Serg on 19/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class HeaderNewsfeedCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.clipsToBounds = true
    }
    
    weak var viewModel: NewsfeedHeaderCellModel? {
        didSet {
            guard let model = viewModel else { return }
            self.nickName.text = model.name
            self.dateLabel.text = model.date
            self.userImage.set(imageURL: model.imageUrl)
            //self.userImage.layer.cornerRadius = userImage.frame.width / 2
        }
    }
}
