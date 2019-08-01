//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Serg on 09/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: TableViewCellViewModel?) {
        nameLabel.text = viewModel?.name
        dateLabel.text = viewModel?.date
        postLabel.text = viewModel?.text
        likesLabel.text = viewModel?.likes
        commentsLabel.text = viewModel?.comments
        sharesLabel.text = viewModel?.shares
        viewsLabel.text = viewModel?.views
    }
}
