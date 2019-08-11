//
//  LoaderView.swift
//  VKNewsFeed
//
//  Created by Serg on 24/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var loader: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    private func layout() {
        let loader = UIActivityIndicatorView()
        loader.color = UIColor.black
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        self.loader = loader
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func cancelLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
}

