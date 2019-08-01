//
//  New.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 07/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit


// как скрыть реализацию? можно ли?

class RoundedDesing: IButtonDising {
    
    var bounds = AdjustingBounds(borderWidth: 2,cornerRadius: 5, margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    var background = Background(backgroundColor: .white)
    
    var fontTitle = Font(font: 20, fontColor: .blue)
    
}

//class RectDesing: IButtonDising {
//
//var bounds = AdjustingBounds(borderWidth: 0,cornerRadius: 0, margin: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//
//var background = Background(backgroundColor: .blue)
//
//var fontTitle = Font(font: 12, fontColor: .white)
//
//}

class RoundedButton: Button {
    override func buildDesing() -> IButtonDising {
        return RoundedDesing()
    }
}
