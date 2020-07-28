//
//  FooterViewOverall.swift
//  VKNewsFeed
//
//  Created by Serg on 20.06.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit

class FooterViewOverall: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "150 записей"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .darkGray
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
