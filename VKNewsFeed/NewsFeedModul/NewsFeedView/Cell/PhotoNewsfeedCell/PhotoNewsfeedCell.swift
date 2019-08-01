//
//  PhotoNewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Serg on 24/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class PhotoNewsfeedCell: UITableViewCell {
    
    private var size: CGSize = .zero
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var copy = size
        copy.height = self.size.height
        return copy
    }
    
    func config(size: CGSize) {
        self.size = size
    }
    
    @IBOutlet weak var photoCollectionView: UICollectionView! {
        didSet {
            photoCollectionView.delegate = self
            photoCollectionView.dataSource = self
            
            let nib = UINib(nibName: CollectionViewCellNewsfeed.reuseIdentifier, bundle: Bundle(for: CollectionViewCellNewsfeed.self))
            photoCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellNewsfeed.reuseIdentifier)
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            photoCollectionView.collectionViewLayout = layout
        }
    }
    
    var photoModels: [PhotoAttachment]?
    
    weak var viewModel: NewsfeedPhotoCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            photoModels = viewModel.attachments
            photoCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}

extension PhotoNewsfeedCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCellNewsfeed = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNewsfeed.reuseIdentifier, for: indexPath) as! CollectionViewCellNewsfeed
        guard let model = photoModels?[indexPath.item] else { return UICollectionViewCell() }
        cell.viewModel = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


