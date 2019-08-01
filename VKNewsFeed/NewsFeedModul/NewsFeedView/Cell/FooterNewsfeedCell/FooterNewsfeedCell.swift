//
//  FooterNewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Serg on 19/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class FooterNewsfeedCell: UITableViewCell {
    
    @IBOutlet weak var lakeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    var viewModel: NewsfeedFooterCellModel? {
        didSet {
            guard let model = viewModel else { return }
            self.lakeLabel.text = model.like
            self.commentLabel.text = model.comment
            self.shareLabel.text = model.share
            self.viewersLabel.text = model.viewers
        }
    }
}
