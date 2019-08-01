//
//  IButtonDising.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 08/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

protocol IButtonDising {
    
    var bounds: AdjustingBounds { get }
    
    var background: Background { get }
    
    var fontTitle: Font { get }

}
