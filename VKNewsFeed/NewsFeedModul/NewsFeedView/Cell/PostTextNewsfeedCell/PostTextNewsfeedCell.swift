//
//  PostTextNewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Serg on 19/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class PostTextNewsfeedCell: UITableViewCell {
    
    @IBOutlet weak var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    var viewModel: NewsfeedTextCellModel? {
        didSet {
            guard let model = viewModel else { return }
            self.postTextLabel.text = model.text
        }
    }
}
