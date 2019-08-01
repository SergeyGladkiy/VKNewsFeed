//
//  AdjustingLabel.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class SettingDisingLabel: ILabelDising {
    
    var fontTitle = Font(font: 20, fontColor: .black)
    
}

class AdjustingLabel: Label {
    override func buildDising() -> ILabelDising {
        return SettingDisingLabel()
    }
}
