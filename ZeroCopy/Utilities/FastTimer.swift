//
//  FastTimer.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 30/01/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import Foundation

protocol TimerDelegate {
    func updateView(with seconds: Int)
}

class FastTimer {
    var seconds = 0
    var timer = Timer()
    var isRunning = false
    var startDate = Date()
    var endDate = Date()
    var delegate: TimerDelegate?
    
    public func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isRunning = true
        startDate = Date()
    }
    
    @objc private func updateTimer(){
        seconds += 1
        if let delegate = delegate {
            delegate.updateView(with: seconds)
        }
    }
    
    public func stopTimer(){
        timer.invalidate()
        seconds = 0
        isRunning = false
    }
    
    public func getTimerDates() -> (Date, Date) {
        endDate = Date()
        return (startDate, endDate)
    }
}
