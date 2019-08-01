//
//  RegisteredField.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class SettingDisingField: IFieldDising {
    
    var bounds = AdjustingBounds(borderWidth: 1, cornerRadius: 4, margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    var background = Background(backgroundColor: .blue)
    
    var fontTitle = Font(font: 19, fontColor: .white)
    
}

class AdjustingField: Field {
    override func buildDesing() -> IFieldDising {
        return SettingDisingField()
    }
}
