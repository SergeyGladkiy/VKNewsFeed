//
//  Button.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 08/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class Button: UIButton {
    //    init() {            // 2 вариант
    //        super.init(frame: CGRect.zero)
    //        let design = buildDesing()
    //        setTitle(design.text, for: .normal)
    //        backgroundColor = design.backgroundColor
    //        setTitleColor(design.fontColor, for: .normal)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func layoutSubviews() {    // 1 вариант
        super.layoutSubviews()
        let design = buildDesing()
        layer.cornerRadius = design.bounds.cornerRadius
        layer.borderWidth = design.bounds.borderWidth
        layoutMargins = design.bounds.margin
        titleLabel?.font = .systemFont(ofSize: 21)
        setTitleColor(design.fontTitle.fontColor, for: .normal)
        backgroundColor = design.background.backgroundColor
    }
    
    func buildDesing() -> IButtonDising {
        fatalError("переопредели со своим дизайном, редиска")
        
    }
}
