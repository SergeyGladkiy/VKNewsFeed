//
//  RepeatingTimer.swift
//  VKNewsFeed
//
//  Created by Serg on 30/07/2019.
//  Copyright © 2019 Sergey Gladkiy. All rights reserved.
//

import Foundation

class RepeatingTimer {
    private enum State {
        case suspended
        case resumed
    }
    private var state: State = .suspended
    private lazy var _timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now()  /*+ self.timeInterval*/, repeating: 1.0)//self.timeInterval)
        timer.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return timer
    }()
    var eventHandler: (() -> Void)?
    let timeInterval: TimeInterval
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    deinit {
        _timer.setEventHandler {}
        _timer.cancel()
        /*
         Если таймер был suspended, то вызов cancel без resuming вызовет
         краш! Боле подробно можно посмотреть -
         https://forums.developer.apple.com/thread/15902
         */
        resume()
        eventHandler = nil
    }
}

extension RepeatingTimer: RepeatingTimerProtocol {
    func resume() {
        guard state != .resumed else {
            return
        }
        state = .resumed
        _timer.resume()
    }
    
    func suspend() {
        guard state != .suspended else {
            return
        }
        state = .suspended
        _timer.suspend()
    }
}
