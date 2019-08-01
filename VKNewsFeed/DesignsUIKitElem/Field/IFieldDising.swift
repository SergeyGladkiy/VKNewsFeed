//
//  IFieldDising.swift
//  lesson9(CashMachine)
//
//  Created by Serg on 11/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

protocol IFieldDising {
    
    var bounds: AdjustingBounds { get }
    
    var background: Background { get }
    
    var fontTitle: Font { get }
}
