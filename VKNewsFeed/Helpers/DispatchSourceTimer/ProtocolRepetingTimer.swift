//
//  ProtocolRepetingTimer.swift
//  VKNewsFeed
//
//  Created by Serg on 06/08/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

protocol RepeatingTimerProtocol: class {
    var eventHandler: (() -> Void)? { get set }
    
    func resume()
    func suspend()
}
