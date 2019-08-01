//
//  CellReusable.swift
//  VKNewsFeed
//
//  Created by Serg on 23/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

protocol CellReusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CellReusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
